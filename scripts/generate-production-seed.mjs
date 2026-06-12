import fs from 'node:fs/promises'
import path from 'node:path'

const output = path.resolve('src/seed_data.sql')
const demoPasswordHash = '$2b$10$WS.aEAGnXkZm96.FS9RMkOMTj2kQOzP74EPWAjmOatU1FlgCRkU9i'

const catalog = [
  {
    name: 'Cơm',
    emoji: '🍚',
    imageRestaurantStart: 1001,
    price: [35000, 85000],
    restaurants: [
      ['Cơm Tấm Sài Gòn', 'Cơm tấm truyền thống'],
      ['Bếp Mẹ Ơi', 'Cơm nhà đúng vị'],
      ['Cơm Niêu Thiên Phúc', 'Cơm niêu gia đình'],
      ['Cơm Gà Hội An', 'Cơm gà miền Trung'],
      ['Cơm Gà Xối Mỡ A Mập', 'Cơm gà giòn nóng'],
      ['Cơm Văn Phòng An Nhiên', 'Bữa trưa đủ chất'],
    ],
    foods: [
      ['Cơm tấm sườn bì chả', 'Sườn nướng, bì heo, chả trứng và cơm tấm dẻo'],
      ['Cơm gà xối mỡ', 'Đùi gà da giòn ăn cùng cơm chiên tỏi'],
      ['Cơm thịt kho trứng', 'Thịt ba chỉ kho mềm, trứng và rau luộc'],
      ['Cơm sườn nướng mật ong', 'Sườn cốt lết nướng mật ong thơm đậm'],
      ['Cơm bò lúc lắc', 'Bò áp chảo, ớt chuông và khoai tây'],
      ['Cơm cá kho tộ', 'Cá kho tiêu trong niêu đất, vị mặn ngọt'],
      ['Cơm gà rô ti', 'Gà rô ti mềm, sốt ngũ vị và dưa chua'],
      ['Cơm chiên hải sản', 'Cơm chiên tơi với tôm, mực và rau củ'],
      ['Cơm niêu sườn rim', 'Sườn non rim mặn ngọt dùng với cơm niêu'],
      ['Cơm phần đặc biệt', 'Phần cơm đầy đủ món mặn, rau và canh'],
    ],
  },
  {
    name: 'Bún - Phở',
    emoji: '🍜',
    imageRestaurantStart: 1006,
    price: [35000, 90000],
    restaurants: [
      ['Phở Hà Nội 1946', 'Phở bò truyền thống'],
      ['Bún Bò Huế Mụ Rơi', 'Bún bò Huế chuẩn vị'],
      ['Phở Thìn Lò Đúc', 'Phở bò tái lăn'],
      ['Bún Riêu Cô Ba', 'Bún riêu cua đồng'],
      ['Bún Chả Hà Nội', 'Bún chả than hoa'],
      ['Phở Gà Phố Cổ', 'Phở gà thanh ngọt'],
    ],
    foods: [
      ['Phở bò tái', 'Bò tái mềm, bánh phở và nước dùng hầm xương'],
      ['Phở bò tái nạm', 'Bò tái, nạm mềm và hành thơm'],
      ['Phở gà ta', 'Gà ta xé, nước dùng trong và lá chanh'],
      ['Bún bò Huế đặc biệt', 'Bò, giò heo, chả cua và nước dùng sả ớt'],
      ['Bún riêu cua', 'Riêu cua đồng, đậu hũ, cà chua và mắm tôm'],
      ['Bún chả Hà Nội', 'Thịt nướng than hoa, chả viên và nước mắm'],
      ['Bún thịt nướng', 'Thịt nướng sả, đồ chua, rau và đậu phộng'],
      ['Bún mọc', 'Mọc thịt, sườn non và nước dùng thanh'],
      ['Bún cá', 'Cá chiên giòn, bún tươi và rau cần'],
      ['Phở đặc biệt', 'Tái, nạm, gân, bò viên trong tô lớn'],
    ],
  },
  {
    name: 'Bánh mì',
    emoji: '🥖',
    imageRestaurantStart: 1011,
    price: [18000, 45000],
    restaurants: [
      ['Bánh Mì Huỳnh Hoa', 'Bánh mì đầy đặn Sài Gòn'],
      ['Bánh Mì Phượng', 'Bánh mì Hội An'],
      ['Bánh Mì Như Lan', 'Bánh mì lâu đời'],
      ['Bánh Mì Chảo Cô Ba', 'Bánh mì chảo nóng'],
      ['Bánh Mì Pate Sài Gòn', 'Pate nhà làm'],
      ['Bánh Mì Ốp La 24H', 'Bánh mì nóng cả ngày'],
    ],
    foods: [
      ['Bánh mì đặc biệt', 'Pate, chả lụa, thịt nguội và rau thơm'],
      ['Bánh mì thịt nướng', 'Thịt nướng sả, đồ chua và sốt bơ'],
      ['Bánh mì heo quay', 'Heo quay da giòn, dưa leo và nước sốt'],
      ['Bánh mì xíu mại', 'Xíu mại mềm, sốt cà chua và hành ngò'],
      ['Bánh mì chả cá', 'Chả cá chiên nóng, rau răm và tương ớt'],
      ['Bánh mì gà xé', 'Gà xé, pate, sốt trứng và rau thơm'],
      ['Bánh mì bò nướng', 'Bò nướng tiêu đen, hành tây và xà lách'],
      ['Bánh mì pate trứng', 'Pate nhà làm và hai trứng ốp la'],
      ['Bánh mì chảo bò', 'Bò né, trứng, xíu mại kèm bánh mì'],
      ['Bánh mì que', 'Bánh mì que giòn với pate và chà bông'],
    ],
  },
  {
    name: 'Đồ uống',
    emoji: '🧋',
    imageRestaurantStart: 1016,
    price: [18000, 65000],
    restaurants: [
      ['Trà Sữa Gong Cha', 'Trà sữa Đài Loan'],
      ['KOI Thé', 'Trà sữa kem macchiato'],
      ['TocoToco Bubble Tea', 'Trà sữa topping đa dạng'],
      ['Phúc Long Coffee & Tea', 'Trà và cà phê Việt'],
      ['The Alley Việt Nam', 'Sữa tươi đường nâu'],
      ['Highlands Coffee Express', 'Cà phê Việt hiện đại'],
    ],
    foods: [
      ['Trà sữa trân châu đen', 'Trà sữa thơm, trân châu đen dẻo'],
      ['Sữa tươi trân châu đường đen', 'Sữa tươi và đường nâu caramel'],
      ['Trà đào cam sả', 'Trà đào, cam vàng và sả tươi'],
      ['Matcha latte', 'Matcha Nhật Bản hòa cùng sữa tươi'],
      ['Trà ô long kem cheese', 'Ô long rang và lớp kem cheese mặn nhẹ'],
      ['Cà phê sữa đá', 'Cà phê rang đậm pha cùng sữa đặc'],
      ['Cold brew cam vàng', 'Cold brew dịu nhẹ với cam vàng'],
      ['Hồng trà macchiato', 'Hồng trà thơm cùng kem macchiato'],
      ['Chocolate đá xay', 'Chocolate, sữa và kem tươi'],
      ['Trà vải nha đam', 'Trà thanh mát, vải và nha đam giòn'],
    ],
  },
  {
    name: 'Gà rán',
    emoji: '🍗',
    imageRestaurantStart: 1021,
    price: [35000, 180000],
    restaurants: [
      ['KFC Việt Nam', 'Gà rán giòn tan'],
      ['Texas Chicken', 'Gà rán vị Texas'],
      ['Popeyes Louisiana Kitchen', 'Gà rán Louisiana'],
      ['Lotteria Chicken', 'Gà rán Hàn Quốc'],
      ['Gà Rán Seoul', 'Gà sốt Hàn Quốc'],
      ['Chicken Plus', 'Gà rán và sốt đặc biệt'],
    ],
    foods: [
      ['Gà rán truyền thống', 'Hai miếng gà giòn theo công thức riêng'],
      ['Gà rán cay', 'Gà giòn phủ gia vị cay thơm'],
      ['Gà sốt tương tỏi', 'Gà rán phủ sốt tương tỏi Hàn Quốc'],
      ['Gà sốt mật ong', 'Gà không xương sốt mật ong ngọt dịu'],
      ['Cánh gà chiên nước mắm', 'Cánh gà giòn áo sốt nước mắm'],
      ['Burger gà giòn', 'Gà giòn, xà lách và sốt mayo'],
      ['Gà popcorn', 'Viên gà nhỏ giòn, tiện dùng'],
      ['Combo gà cá nhân', 'Hai miếng gà, khoai tây và nước'],
      ['Combo gà gia đình', 'Sáu miếng gà, khoai và salad'],
      ['Khoai tây chiên', 'Khoai tây vàng giòn rắc muối'],
    ],
  },
  {
    name: 'Pizza',
    emoji: '🍕',
    imageRestaurantStart: 1026,
    price: [79000, 299000],
    restaurants: [
      ['Pizza Hut', 'Pizza Ý phong phú'],
      ["Domino's Pizza", 'Pizza giao nhanh'],
      ["Pizza 4P's", 'Pizza phô mai thủ công'],
      ['The Pizza Company', 'Pizza đa topping'],
      ['Pizza Roma', 'Pizza đế mỏng Roma'],
      ['Pizza Home', 'Pizza nóng tại nhà'],
    ],
    foods: [
      ['Pizza Pepperoni', 'Pepperoni, mozzarella và sốt cà chua'],
      ['Pizza hải sản', 'Tôm, mực, thanh cua và sốt mayonnaise'],
      ['Pizza BBQ gà', 'Gà nướng BBQ, hành tây và ớt chuông'],
      ['Pizza bốn phô mai', 'Mozzarella, cheddar, parmesan và gouda'],
      ['Pizza Margherita', 'Cà chua, mozzarella và húng quế'],
      ['Pizza bò bằm', 'Bò bằm, nấm, hành tây và phô mai'],
      ['Pizza Hawaiian', 'Thịt nguội, dứa và mozzarella'],
      ['Pizza xúc xích Ý', 'Xúc xích Ý, olive và ớt chuông'],
      ['Pizza nấm truffle', 'Nấm hỗn hợp, dầu truffle và phô mai'],
      ['Pizza rau củ nướng', 'Bí ngòi, cà tím, ớt chuông và nấm'],
    ],
  },
  {
    name: 'Lẩu',
    emoji: '🫵',
    imageRestaurantStart: 1031,
    price: [159000, 499000],
    restaurants: [
      ['Lẩu Thái Mama', 'Lẩu Thái cay nồng'],
      ['Hotpot Story', 'Lẩu nhiều vị'],
      ['Manwah Taiwanese Hotpot', 'Lẩu Đài Loan'],
      ['Lẩu Gà Lá É Đà Lạt', 'Lẩu gà lá é'],
      ['Lẩu Bò Sài Gòn', 'Lẩu bò nóng hổi'],
      ['Kichi Hotpot', 'Lẩu băng chuyền tại nhà'],
    ],
    foods: [
      ['Lẩu Thái hải sản', 'Tôm, mực, nghêu và nước lẩu chua cay'],
      ['Lẩu bò Mỹ', 'Ba chỉ bò Mỹ, nấm và rau theo mùa'],
      ['Lẩu gà lá é', 'Gà ta, lá é, măng và ớt xiêm xanh'],
      ['Lẩu nấm', 'Nhiều loại nấm, rau củ và nước dùng thanh'],
      ['Lẩu mala Đài Loan', 'Nước lẩu mala cay tê cùng thịt bò'],
      ['Lẩu kim chi', 'Kim chi Hàn Quốc, ba chỉ heo và đậu hũ'],
      ['Lẩu riêu cua bắp bò', 'Riêu cua, bắp bò, đậu hũ và rau'],
      ['Lẩu cá kèo', 'Cá kèo tươi, lá giang và rau đắng'],
      ['Lẩu bò nhúng giấm', 'Bò mềm nhúng nước giấm dừa thanh'],
      ['Combo lẩu đặc biệt', 'Thịt, hải sản, viên thả lẩu và rau'],
    ],
  },
  {
    name: 'Chay',
    emoji: '🥗',
    imageRestaurantStart: 1036,
    price: [35000, 120000],
    restaurants: [
      ['Cơm Chay Thiên Lý', 'Ẩm thực chay thanh tịnh'],
      ['Hum Vegetarian', 'Chay cao cấp'],
      ['Chay Garden', 'Vườn chay xanh'],
      ['Bông Súng Vegetarian', 'Món chay Việt'],
      ['Nhà Hàng Chay An Lạc', 'Chay gia đình'],
      ['Lá Bồ Đề Vegan', 'Món chay thuần thực vật'],
    ],
    foods: [
      ['Cơm chay thập cẩm', 'Cơm, đậu hũ, nấm và rau củ theo ngày'],
      ['Bún Huế chay', 'Bún, đậu hũ, nấm và nước dùng sả'],
      ['Phở chay', 'Phở, nấm, tàu hũ ky và rau thơm'],
      ['Cơm gạo lứt', 'Gạo lứt, rau củ, hạt và sốt mè'],
      ['Đậu hũ kho nấm', 'Đậu hũ non kho nấm đông cô đậm vị'],
      ['Gỏi cuốn chay', 'Rau, bún, đậu hũ cuốn bánh tráng'],
      ['Mì xào rau củ', 'Mì xào nấm và rau củ theo mùa'],
      ['Cà ri chay', 'Khoai, đậu hũ và nước cốt dừa'],
      ['Lẩu nấm chay', 'Nấm tươi, đậu hũ và rau xanh'],
      ['Salad đậu hũ', 'Đậu hũ áp chảo, rau xanh và sốt mè'],
    ],
  },
]

function quote(value) {
  return `'${String(value).replaceAll('\\', '\\\\').replaceAll("'", "''")}'`
}

function priceAt([min, max], index) {
  const step = Math.floor((max - min) / 9 / 1000) * 1000
  return Math.min(max, min + step * index)
}

function assetIds(start) {
  const ids = []
  for (let restaurantOffset = 0; ids.length < 10; restaurantOffset += 1) {
    for (let foodOffset = 1; foodOffset <= 4 && ids.length < 10; foodOffset += 1) {
      ids.push(Number(`${start + restaurantOffset}${foodOffset}`))
    }
  }
  return ids
}

const lines = [
  'SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;',
  'SET FOREIGN_KEY_CHECKS = 1;',
  '',
  '-- Roles and demo users. Existing production users are never overwritten.',
  `INSERT INTO roles (id, role_name, description) VALUES
  (1, 'ADMIN', 'Quản trị viên hệ thống'),
  (2, 'USER', 'Khách hàng FoodHub')
ON DUPLICATE KEY UPDATE description = VALUES(description);`,
  '',
  `INSERT IGNORE INTO users (id, user_name, password, fullname, create_date, role_id) VALUES
  (1, 'admin', ${quote(demoPasswordHash)}, 'Admin System', NOW(), 1),
  (2, 'nguyenvana', ${quote(demoPasswordHash)}, 'Nguyễn Văn A', NOW(), 2);`,
  '',
]

catalog.forEach((category, categoryIndex) => {
  const categoryId = categoryIndex + 1
  lines.push(
    `INSERT INTO category (id, category_name, create_date) VALUES (${categoryId}, ${quote(category.name)}, NOW())
ON DUPLICATE KEY UPDATE category_name = VALUES(category_name);`,
    '',
  )
})

let restaurantId = 1001
let foodCount = 0

catalog.forEach((category, categoryIndex) => {
  const categoryId = categoryIndex + 1
  const images = assetIds(category.imageRestaurantStart)

  category.restaurants.forEach(([restaurantName, subtitle], restaurantIndex) => {
    const currentRestaurantId = restaurantId
    const district = ((restaurantId - 1001) % 12) + 1
    const address = `${18 + restaurantIndex * 11} Đường FoodHub, Quận ${district}, TP.HCM`
    const restaurantImage = `/images/foods/${images[restaurantIndex % images.length]}.jpg`
    const description = `${subtitle}. Chuyên phục vụ ${category.name.toLowerCase()} với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.`

    lines.push(
      `INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (${currentRestaurantId}, ${quote(restaurantName)}, ${quote(subtitle)}, ${quote(description)}, ${quote(restaurantImage)}, ${restaurantIndex % 3 === 0 ? 1 : 0}, ${quote(address)}, NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);`,
      `INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (${categoryId}, ${currentRestaurantId}, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);`,
      '',
    )

    category.foods.forEach(([foodName, foodDescription], foodIndex) => {
      const foodId = currentRestaurantId * 100 + foodIndex + 1
      const image = `/images/foods/${images[foodIndex]}.jpg`
      const title = `${foodName}${restaurantIndex === 0 ? '' : ` - ${restaurantName}`}`
      const description = `${foodDescription}. Món được chuẩn bị mới tại ${restaurantName}.`
      const price = priceAt(category.price, foodIndex)
      const deliveryTime = category.name === 'Lẩu' || category.name === 'Pizza' ? '30-45 phút' : '20-30 phút'

      lines.push(
        `INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (${foodId}, ${quote(title)}, ${quote(description)}, ${quote(image)}, ${quote(deliveryTime)}, ${price}, ${restaurantIndex % 3 === 0 ? 1 : 0}, ${categoryId}, ${currentRestaurantId})
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);`,
        '',
      )
      foodCount += 1
    })

    restaurantId += 1
  })
})

lines.push(
  '-- Seed summary: 8 categories, 48 restaurants, 480 foods.',
  `SELECT ${catalog.length} AS seeded_categories, ${restaurantId - 1001} AS seeded_restaurants, ${foodCount} AS seeded_foods;`,
  '',
)

await fs.writeFile(output, lines.join('\n'), 'utf8')
console.log(`Generated ${output}`)
console.log(`Categories: ${catalog.length}`)
console.log(`Restaurants: ${restaurantId - 1001}`)
console.log(`Foods: ${foodCount}`)
