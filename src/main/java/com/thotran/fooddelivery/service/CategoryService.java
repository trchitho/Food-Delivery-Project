package com.thotran.fooddelivery.service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.thotran.fooddelivery.dto.CategoryDto;
import com.thotran.fooddelivery.dto.MenuDto;
import com.thotran.fooddelivery.entity.Category;
import com.thotran.fooddelivery.entity.Food;
import com.thotran.fooddelivery.repository.CategoryRepository;
import com.thotran.fooddelivery.service.imp.CategoryServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
@Service
public class CategoryService implements CategoryServiceImp {
    @Autowired
    CategoryRepository categoryRepository;

    @Autowired(required = false)
    RedisTemplate redisTemplate;

    private Gson gson = new Gson();
    @Override
    @Transactional(readOnly = true)
    public List<CategoryDto> getCategoryHomepage() {

        String dataRedis = null;
        try {
            if (redisTemplate != null) {
                dataRedis = (String) redisTemplate.opsForValue().get("category");
            }
        } catch (Exception e) {
            // Redis not available, skip cache
        }

        List<CategoryDto> categoryDtoList = new ArrayList<>();

        if(dataRedis == null){

            List<Category> categoryList = categoryRepository.findAll(Sort.by("id"));

            for (Category data : categoryList){
                CategoryDto categoryDto = new CategoryDto();
                categoryDto.setId(data.getId());
                categoryDto.setName(data.getCategoryName());

                List<MenuDto> menuDtos = new ArrayList<>();
                for (Food dataFood : data.getFoodList()){
                    MenuDto menuDto = new MenuDto();
                    menuDto.setId(dataFood.getId());
                    menuDto.setTitle(dataFood.getTitle());
                    menuDto.setFreeShip(dataFood.isFreeShip());
                    menuDto.setImage(dataFood.getImage());
                    menuDto.setDescription(dataFood.getDesccription());
                    menuDto.setPrice(dataFood.getPrice());
                    if (dataFood.getRestaurant() != null) {
                        menuDto.setRestaurantId(dataFood.getRestaurant().getId());
                        menuDto.setRestaurantTitle(dataFood.getRestaurant().getTitle());
                    }

                    menuDtos.add(menuDto);
                }

                categoryDto.setMenus(menuDtos);

                categoryDtoList.add(categoryDto);
            }
            try {
                if (redisTemplate != null) {
                    String dataJson = gson.toJson(categoryDtoList);
                    redisTemplate.opsForValue().set("category", dataJson);
                }
            } catch (Exception e) {
                // Redis not available, skip cache write
            }
        }else {
            Type listType = new TypeToken<List<CategoryDto>>(){}.getType();
            categoryDtoList = gson.fromJson(dataRedis,listType);

        }

        return categoryDtoList;
    }
}
