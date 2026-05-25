package com.thotran.fooddelivery.service;

import com.thotran.fooddelivery.dto.CategoryDto;
import com.thotran.fooddelivery.dto.MenuDto;
import com.thotran.fooddelivery.dto.RestaurantDto;
import com.thotran.fooddelivery.entity.Food;
import com.thotran.fooddelivery.entity.RatingRestaurant;
import com.thotran.fooddelivery.entity.Restaurant;
import com.thotran.fooddelivery.entity.RestaurantCategory;
import com.thotran.fooddelivery.repository.RestaurantRepository;
import com.thotran.fooddelivery.service.imp.FileServiceImp;
import com.thotran.fooddelivery.service.imp.RestaurantServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class RestaurantService implements RestaurantServiceImp {
    @Autowired
    RestaurantRepository restaurantRepository;

    @Autowired
    FileServiceImp fileServiceImp;

    @Override
    public boolean createRestaurant(MultipartFile file, String title, String subtitle, String description, boolean isFreeShip, String address, String openDate) {
        boolean isCreateSuccessful = false;
        try{
            boolean isSaveFileSuccessful = fileServiceImp.saveFile(file);
            if (isSaveFileSuccessful){
                Restaurant restaurant = new Restaurant();
                restaurant.setTitle(title);
                restaurant.setSubtitle(subtitle);
                restaurant.setDescription(description);
                restaurant.setImage(file.getOriginalFilename());
                restaurant.setFreeShip(isFreeShip);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
                Date opendate = simpleDateFormat.parse(openDate);
                restaurant.setOpenDate(opendate);
                restaurant.setAddress(address);

                restaurantRepository.save(restaurant);
                isCreateSuccessful = true;
            }
        }catch (Exception e){
            System.out.println("Fail to create restaurant: " + e.getMessage());
        }

        return isCreateSuccessful;
    }

    @Override
    public List<RestaurantDto> getRestaurantList() {
        List<RestaurantDto> restaurantDtos = new ArrayList<>();
        List<Restaurant> restaurantList = restaurantRepository.findAll();

        for (Restaurant restaurant : restaurantList){
            RestaurantDto restaurantDto = new RestaurantDto();
            restaurantDto.setId(restaurant.getId());
            restaurantDto.setImage(restaurant.getImage());
            restaurantDto.setTitle(restaurant.getTitle());
            restaurantDto.setSubtitle(restaurant.getSubtitle());
            restaurantDto.setDescription(restaurant.getDescription());
            restaurantDto.setAddress(restaurant.getAddress());
            restaurantDto.setOpenDate(restaurant.getOpenDate());
            restaurantDto.setFreeShip(restaurant.isFreeShip());
            restaurantDto.setRating(calculatorRating(restaurant.getRatingRestaurants()));
            List<String> categoryNames = new ArrayList<>();
            for (RestaurantCategory restaurantCategory : restaurant.getRestaurantCategories()){
                categoryNames.add(restaurantCategory.getCategory().getCategoryName());
            }
            restaurantDto.setCategoryNames(categoryNames);

            restaurantDtos.add(restaurantDto);
        }
        return restaurantDtos;
    }

    private double calculatorRating(Set<RatingRestaurant> ratingList){
        if (ratingList == null || ratingList.isEmpty()){
            return 0;
        }
        double totalPoint = 0;
        for (RatingRestaurant data : ratingList){
            totalPoint += data.getRatingPoint();
        }
        return totalPoint/ratingList.size();
    }

    @Override
    public RestaurantDto getRestaurantDetail(int id) {
        Optional<Restaurant> restaurant = restaurantRepository.findById(id);
        RestaurantDto restaurantDto = new RestaurantDto();

        if (restaurant.isPresent()){
            List<CategoryDto> categoryDtoList = new ArrayList<>();
            Restaurant data = restaurant.get();

            restaurantDto.setId(data.getId());
            restaurantDto.setTitle(data.getTitle());
            restaurantDto.setSubtitle(data.getSubtitle());
            restaurantDto.setDescription(data.getDescription());
            restaurantDto.setImage(data.getImage());
            restaurantDto.setRating(calculatorRating(data.getRatingRestaurants()));
            restaurantDto.setFreeShip(data.isFreeShip());
            restaurantDto.setOpenDate(data.getOpenDate());
            restaurantDto.setAddress(data.getAddress());

            for (RestaurantCategory restaurantCategory : data.getRestaurantCategories()){
                List<MenuDto> menuDtoList = new ArrayList<>();
                CategoryDto categoryDto = new CategoryDto();
                categoryDto.setName(restaurantCategory.getCategory().getCategoryName());
                categoryDto.setId(restaurantCategory.getCategory().getId());

                for (Food food : restaurantCategory.getCategory().getFoodList()){
                    if (food.getRestaurant() == null || food.getRestaurant().getId() != data.getId()){
                        continue;
                    }
                    MenuDto menuDto = new MenuDto();
                    menuDto.setId(food.getId());
                    menuDto.setImage(food.getImage());
                    menuDto.setFreeShip(food.isFreeShip());
                    menuDto.setTitle(food.getTitle());
                    menuDto.setDescription(food.getDesccription());
                    menuDto.setPrice(food.getPrice());
                    menuDto.setRestaurantId(data.getId());
                    menuDto.setRestaurantTitle(data.getTitle());

                    menuDtoList.add(menuDto);
                }
                categoryDto.setMenus(menuDtoList);
                categoryDtoList.add(categoryDto);
            }
            restaurantDto.setCategories(categoryDtoList);
        }

        return restaurantDto;
    }
}
