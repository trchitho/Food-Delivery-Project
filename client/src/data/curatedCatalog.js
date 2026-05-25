const img = (id, width = 900) => `https://images.unsplash.com/${id}?auto=format&fit=crop&w=${width}&q=80`

const CATEGORY_META = [
  ['Cơm', '🍚'],
  ['Bún - Phở', '🍜'],
  ['Bánh mì', '🥖'],
  ['Đồ uống', '🧋'],
  ['Gà rán', '🍗'],
  ['Pizza', '🍕'],
  ['Lẩu', '🫵'],
  ['Chay', '🥗'],
]

const RESTAURANT_IMAGES = {
  'Cơm Tấm Sài Gòn': img('photo-1512058564366-18510be2db19'),
  'Bếp Mẹ Ơi': img('photo-1546069901-ba9599a7e63c'),
  'Cơm Niêu Thiên Phúc': img('photo-1603133872878-684f208fb84b'),
  'Cơm Gà Hội An': img('photo-1516684732162-798a0062be99'),
  'Cơm Gà Xối Mỡ A Mập': img('photo-1626645738196-c2a7c87a8f58'),
  'Phở Hà Nội 1946': img('photo-1582878826629-29b7ad1cdc43'),
  'Bún Bò Huế Mụ Rơi': img('photo-1555126634-323283e090fa'),
  'Phở Thìn Lò Đúc': img('photo-1569050467447-ce54b3bbc37d'),
  'Bún Riêu Cô Ba': img('photo-1569718212165-3a8278d5f624'),
  'Bún Chả Hà Nội': img('photo-1529042410759-befb1204b468'),
  'Bánh Mì Huỳnh Hoa': img('photo-1509722747041-616f39b57569'),
  'Bánh Mì Phượng': img('photo-1528735602780-2552fd46c7af'),
  'Bánh Mì Như Lan': img('photo-1481070414801-51fd732d7184'),
  'Bánh Mì Chảo Cô Ba': img('photo-1553909489-cd47e0907980'),
  'Bánh Mì Pate Sài Gòn': img('photo-1509440159596-0249088772ff'),
  'Trà Sữa Gong Cha': img('photo-1558618666-fcd25c85cd64'),
  'KOI Thé': img('photo-1525385133512-2f3bdd039054'),
  'TocoToco Bubble Tea': img('photo-1544145945-f90425340c7e'),
  'Phúc Long Coffee & Tea': img('photo-1515823064-d6e0c04616a7'),
  'The Alley Việt Nam': img('photo-1551024709-8f23befc6f87'),
  'KFC Việt Nam': img('photo-1626645738196-c2a7c87a8f58'),
  'Texas Chicken': img('photo-1562967914-608f82629710'),
  'Popeyes Louisiana Kitchen': img('photo-1598514983318-2f64f8f4796c'),
  'Lotteria Chicken': img('photo-1606755962773-d324e0a13086'),
  'Gà Rán Seoul': img('photo-1567620832903-9fc6debc209f'),
  'Pizza Hut': img('photo-1565299624946-b28f40a0ae38'),
  "Domino's Pizza": img('photo-1628840042765-356cda07504e'),
  "Pizza 4P's": img('photo-1513104890138-7c749659a591'),
  'The Pizza Company': img('photo-1574071318508-1cdbab80d002'),
  'Pizza Roma': img('photo-1594007654729-407eedc4be65'),
  'Lẩu Thái Mama': img('photo-1547592180-85f173990554'),
  'Hotpot Story': img('photo-1569718212165-3a8278d5f624'),
  'Manwah Taiwanese Hotpot': img('photo-1547592166-23ac45744acd'),
  'Lẩu Gà Lá É Đà Lạt': img('photo-1604909052743-94e838986d24'),
  'Lẩu Bò Sài Gòn': img('photo-1615361200141-f45040f367be'),
  'Cơm Chay Thiên Lý': img('photo-1512621776951-a57141f2eefd'),
  'Hum Vegetarian': img('photo-1540189549336-e6e99c3679fe'),
  'Chay Garden': img('photo-1498837167922-ddd27525d352'),
  'Bông Súng Vegetarian': img('photo-1505576399279-565b52d4ac71'),
  'Nhà Hàng Chay An Lạc': img('photo-1511690743698-d9d85f2fbf38'),
}

const RESTAURANT_SPECS = [
  ['Cơm', 'Cơm Tấm Sài Gòn', 'Cơm tấm truyền thống', ['Cơm tấm sườn bì chả', 'Cơm tấm sườn nướng', 'Cơm tấm bì chả', 'Cơm tấm đặc biệt']],
  ['Cơm', 'Bếp Mẹ Ơi', 'Cơm nhà đúng vị', ['Cơm canh chua cá lóc', 'Cơm thịt kho tàu', 'Cơm gà kho gừng', 'Cơm sườn ram mặn']],
  ['Cơm', 'Cơm Niêu Thiên Phúc', 'Cơm niêu gia đình', ['Cơm niêu cá kho', 'Cơm niêu bò lúc lắc', 'Cơm niêu sườn rim', 'Cơm niêu gà xé']],
  ['Cơm', 'Cơm Gà Hội An', 'Cơm gà miền Trung', ['Cơm gà xé Hội An', 'Cơm gà rô ti', 'Cơm gà xối mỡ', 'Cơm gà sốt tiêu']],
  ['Cơm', 'Cơm Gà Xối Mỡ A Mập', 'Cơm gà giòn nóng', ['Cơm gà đùi giòn', 'Cơm gà cánh giòn', 'Cơm gà sốt mắm', 'Cơm gà phô mai']],
  ['Bún - Phở', 'Phở Hà Nội 1946', 'Phở bò truyền thống', ['Phở bò tái', 'Phở bò chín', 'Phở bò tái chín', 'Phở gà']],
  ['Bún - Phở', 'Bún Bò Huế Mụ Rơi', 'Bún bò Huế chuẩn vị', ['Bún bò Huế đặc biệt', 'Bún bò Huế thường', 'Bún bò chả cua', 'Bún bò giò heo']],
  ['Bún - Phở', 'Phở Thìn Lò Đúc', 'Phở bò tái lăn', ['Phở bò tái lăn', 'Phở bò nạm', 'Phở bò sốt vang', 'Phở bò viên']],
  ['Bún - Phở', 'Bún Riêu Cô Ba', 'Bún riêu cua đồng', ['Bún riêu cua', 'Bún riêu ốc', 'Bún riêu chả cá', 'Bún riêu đặc biệt']],
  ['Bún - Phở', 'Bún Chả Hà Nội', 'Bún chả than hoa', ['Bún chả thịt nướng', 'Bún chả nem cua', 'Bún nem nướng', 'Bún thịt nướng']],
  ['Bánh mì', 'Bánh Mì Huỳnh Hoa', 'Bánh mì nổi tiếng nhất SG', ['Bánh mì đặc biệt', 'Bánh mì thịt nướng', 'Bánh mì trứng', 'Bánh mì chả cá']],
  ['Bánh mì', 'Bánh Mì Phượng', 'Bánh mì Hội An', ['Bánh mì gà xé', 'Bánh mì bò kho', 'Bánh mì heo quay', 'Bánh mì pate trứng']],
  ['Bánh mì', 'Bánh Mì Như Lan', 'Bánh mì lâu đời', ['Bánh mì thịt nguội', 'Bánh mì xíu mại', 'Bánh mì chả lụa', 'Bánh mì bò nướng']],
  ['Bánh mì', 'Bánh Mì Chảo Cô Ba', 'Bánh mì chảo nóng', ['Bánh mì chảo bò', 'Bánh mì chảo trứng', 'Bánh mì chảo xíu mại', 'Bánh mì chảo đặc biệt']],
  ['Bánh mì', 'Bánh Mì Pate Sài Gòn', 'Pate nhà làm', ['Bánh mì pate', 'Bánh mì pate chả', 'Bánh mì pate heo quay', 'Bánh mì pate bơ']],
  ['Đồ uống', 'Trà Sữa Gong Cha', 'Trà sữa Đài Loan', ['Trà sữa trân châu đen', 'Matcha latte trân châu', 'Taro milk tea', 'Brown sugar milk tea']],
  ['Đồ uống', 'KOI Thé', 'Trà sữa kem macchiato', ['Golden bubble milk tea', 'Trà sữa macchiato', 'Hồng trà sữa KOI', 'Lục trà mật ong']],
  ['Đồ uống', 'TocoToco Bubble Tea', 'Trà sữa topping đa dạng', ['Trà sữa panda', 'Trà sữa ba anh em', 'Sữa tươi trân châu đường đen', 'Trà đào cam sả']],
  ['Đồ uống', 'Phúc Long Coffee & Tea', 'Trà và cà phê Việt', ['Trà đào Phúc Long', 'Trà sữa ô long', 'Cà phê sữa đá', 'Matcha đá xay']],
  ['Đồ uống', 'The Alley Việt Nam', 'Sữa tươi đường nâu', ['Deerioca brown sugar', 'Royal no.9 milk tea', 'Matcha latte alley', 'Trà sữa kem cheese']],
  ['Gà rán', 'KFC Việt Nam', 'Gà rán giòn tan', ['Gà rán Original', 'Combo Gà Bucket', 'Gà Zinger Burger', 'Khoai tây chiên lớn']],
  ['Gà rán', 'Texas Chicken', 'Gà rán vị Texas', ['Gà giòn cay Texas', 'Combo gà sốt mật ong', 'Burger gà Texas', 'Khoai nghiền sốt gravy']],
  ['Gà rán', 'Popeyes Louisiana Kitchen', 'Gà rán Louisiana', ['Gà giòn Cajun', 'Gà sốt BBQ', 'Burger tôm Popeyes', 'Bánh quy bơ mật ong']],
  ['Gà rán', 'Lotteria Chicken', 'Gà rán Hàn Quốc', ['Gà rán sốt H&S', 'Gà rán phô mai', 'Burger gà Bulgogi', 'Khoai lắc phô mai']],
  ['Gà rán', 'Gà Rán Seoul', 'Gà sốt Hàn Quốc', ['Gà sốt cay Hàn', 'Gà sốt tương tỏi', 'Gà không xương', 'Gà popcorn']],
  ['Pizza', 'Pizza Hut', 'Pizza Ý chính hiệu', ['Pizza Pepperoni', 'Pizza Hải Sản', 'Pizza BBQ Gà', 'Pizza 4 Phô Mai']],
  ['Pizza', "Domino's Pizza", 'Pizza giao nhanh', ['Pizza xúc xích Ý', 'Pizza bò bằm', 'Pizza hải sản nhiệt đới', 'Pizza gà nấm']],
  ['Pizza', "Pizza 4P's", 'Pizza phô mai thủ công', ['Pizza burrata', 'Pizza cá hồi', 'Pizza Margherita', 'Pizza nấm truffle']],
  ['Pizza', 'The Pizza Company', 'Pizza đa topping', ['Pizza seafood deluxe', 'Pizza Hawaiian', 'Pizza meat lover', 'Pizza cheese mania']],
  ['Pizza', 'Pizza Roma', 'Pizza đế mỏng Roma', ['Pizza prosciutto', 'Pizza salami cay', 'Pizza gà pesto', 'Pizza rau củ nướng']],
  ['Lẩu', 'Lẩu Thái Mama', 'Lẩu Thái cay nồng', ['Lẩu Thái hải sản', 'Lẩu Thái gà', 'Lẩu Thái chay', 'Lẩu Tomyum bò']],
  ['Lẩu', 'Hotpot Story', 'Lẩu nhiều vị', ['Lẩu collagen', 'Lẩu tomyum', 'Lẩu miso', 'Lẩu nấm']],
  ['Lẩu', 'Manwah Taiwanese Hotpot', 'Lẩu Đài Loan', ['Lẩu mala Đài Loan', 'Lẩu sữa Manwah', 'Lẩu bò Mỹ', 'Lẩu viên tổng hợp']],
  ['Lẩu', 'Lẩu Gà Lá É Đà Lạt', 'Lẩu gà lá é', ['Lẩu gà lá é', 'Lẩu gà nấm', 'Lẩu gà ớt hiểm', 'Lẩu gà măng chua']],
  ['Lẩu', 'Lẩu Bò Sài Gòn', 'Lẩu bò nóng hổi', ['Lẩu bò thập cẩm', 'Lẩu đuôi bò', 'Lẩu bò sa tế', 'Lẩu bò nhúng giấm']],
  ['Chay', 'Cơm Chay Thiên Lý', 'Ẩm thực chay thanh tịnh', ['Cơm chay đặc biệt', 'Bún chay', 'Cơm chay thập cẩm', 'Đậu hũ kho nấm']],
  ['Chay', 'Hum Vegetarian', 'Chay cao cấp', ['Cơm sen Hum', 'Gỏi nấm rong biển', 'Lẩu nấm chay', 'Pad Thái chay']],
  ['Chay', 'Chay Garden', 'Vườn chay xanh', ['Cơm gạo lứt chay', 'Bún Huế chay', 'Nấm kho tiêu', 'Salad đậu hũ']],
  ['Chay', 'Bông Súng Vegetarian', 'Món chay Việt', ['Bông súng mắm chay', 'Cơm chiên chay', 'Canh chua chay', 'Bún mắm chay']],
  ['Chay', 'Nhà Hàng Chay An Lạc', 'Chay gia đình', ['Hủ tiếu chay', 'Mì xào nấm', 'Cà ri chay', 'Cơm tấm chay']],
]

function priceFor(categoryName, index) {
  const base = {
    'Cơm': 45000,
    'Bún - Phở': 55000,
    'Bánh mì': 28000,
    'Đồ uống': 45000,
    'Gà rán': 69000,
    'Pizza': 179000,
    'Lẩu': 220000,
    'Chay': 50000,
  }[categoryName] || 50000
  return base + (index * 10000)
}

export const CURATED_CATEGORIES = CATEGORY_META.map(([name], index) => ({
  id: 1000 + index + 1,
  name,
  title: name,
  menus: [],
}))

export const CURATED_RESTAURANTS = RESTAURANT_SPECS.map(([categoryName, title, subtitle, foodTitles], index) => ({
  id: 1000 + index + 1,
  title,
  subtitle,
  description: `${subtitle}, danh mục ${categoryName}, thực đơn được chuẩn hóa hình ảnh và món bán chạy.`,
  image: RESTAURANT_IMAGES[title],
  freeShip: index % 3 !== 1,
  rating: 4.6 + ((index % 4) * 0.1),
  address: `${12 + index} Nguyễn Văn Trỗi, TP.HCM`,
  categoryNames: [categoryName],
  menus: foodTitles,
}))

export const CURATED_FOODS = RESTAURANT_SPECS.flatMap(([categoryName, restaurantTitle,, foodTitles], restaurantIndex) => {
  const category = CURATED_CATEGORIES.find((item) => item.name === categoryName)
  const restaurant = CURATED_RESTAURANTS[restaurantIndex]
  return foodTitles.map((title, foodIndex) => ({
    id: (restaurant.id * 10) + foodIndex + 1,
    title,
    description: `${title} chế biến theo đúng phong cách ${restaurantTitle}, hình ảnh minh họa cố định theo món.`,
    image: `/images/foods/${restaurant.id}${foodIndex + 1}.jpg`,
    timeShip: categoryName === 'Đồ uống' || categoryName === 'Bánh mì' ? '10-20 phút' : '20-35 phút',
    price: priceFor(categoryName, foodIndex),
    freeShip: restaurant.freeShip,
    status: 'Có sẵn',
    categoryId: category.id,
    categoryName,
    restaurantId: restaurant.id,
    restaurantTitle,
  }))
})

CURATED_CATEGORIES.forEach((category) => {
  category.menus = CURATED_FOODS.filter((food) => food.categoryName === category.name)
})

export const CURATED_RESTAURANT_IMAGES = RESTAURANT_IMAGES
export const CURATED_FOOD_IMAGES = Object.fromEntries(CURATED_FOODS.map((food) => [food.title, food.image]))
