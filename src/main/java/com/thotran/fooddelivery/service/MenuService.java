package com.thotran.fooddelivery.service;

import com.thotran.fooddelivery.entity.Category;
import com.thotran.fooddelivery.entity.Food;
import com.thotran.fooddelivery.entity.Restaurant;
import com.thotran.fooddelivery.repository.FoodRepository;
import com.thotran.fooddelivery.service.imp.FileServiceImp;
import com.thotran.fooddelivery.service.imp.MenuServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MenuService implements MenuServiceImp {

    @Autowired
    FileServiceImp fileServiceImp;
    @Autowired
    FoodRepository foodRepository;

    @Override
    public boolean createMenu(MultipartFile file, String title, boolean isFreeShip, String timeShip, double price, int cate_Id, int res_Id, String description) {
        boolean isCreateSuccessful = false;
        try{
            boolean isSaveFileSuccessful = fileServiceImp.saveFile(file);
            String filename = file.getOriginalFilename();
            if (isSaveFileSuccessful){
                Food food = new Food();
                food.setTitle(title);
                food.setImage(filename);
                food.setTimeShip(timeShip);
                food.setPrice(price);
                food.setFreeShip(isFreeShip);
                food.setDesccription(description);

                Category category = new Category();
                category.setId(cate_Id);
                food.setCategory(category);

                Restaurant restaurant = new Restaurant();
                restaurant.setId(res_Id);
                food.setRestaurant(restaurant);

                foodRepository.save(food);
                isCreateSuccessful = true;
            }
        }catch (Exception e){
            System.out.println("Fail to create restaurant: " + e.getMessage());
        }

        return isCreateSuccessful;
    }
}
