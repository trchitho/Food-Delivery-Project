import fs from 'node:fs/promises'
import path from 'node:path'

const root = process.cwd()
const outputDir = path.join(root, 'client', 'public', 'images', 'foods')

const pexels = (photoId) => `https://images.pexels.com/photos/${photoId}/pexels-photo-${photoId}.jpeg?auto=compress&cs=tinysrgb&w=900&q=80`

const pools = [
  {
    category: 'Cơm',
    restaurantIds: [1001, 1002, 1003, 1004, 1005],
    sources: [
      pexels('6126977'),
      pexels('12916867'),
      pexels('1640777'),
      pexels('1435904'),
      pexels('723198'),
    ],
  },
  {
    category: 'Bún - Phở',
    restaurantIds: [1006, 1007, 1008, 1009, 1010],
    sources: [
      pexels('6646351'),
      pexels('6646069'),
      pexels('11043968'),
      pexels('699953'),
      pexels('1907227'),
    ],
  },
  {
    category: 'Bánh mì',
    restaurantIds: [1011, 1012, 1013, 1014, 1015],
    sources: [
      pexels('35409563'),
      pexels('32961648'),
      pexels('32961649'),
      pexels('6605214'),
      pexels('1600711'),
    ],
  },
  {
    category: 'Đồ uống',
    restaurantIds: [1016, 1017, 1018, 1019, 1020],
    sources: [
      pexels('11160122'),
      pexels('28915280'),
      pexels('35727299'),
      pexels('12940112'),
      pexels('19996404'),
    ],
  },
  {
    category: 'Gà rán',
    restaurantIds: [1021, 1022, 1023, 1024, 1025],
    sources: [
      pexels('12916867'),
      pexels('1893555'),
      pexels('2338407'),
      pexels('106343'),
      pexels('12916867'),
    ],
  },
  {
    category: 'Pizza',
    restaurantIds: [1026, 1027, 1028, 1029, 1030],
    sources: [
      pexels('31596394'),
      pexels('31587831'),
      pexels('31094832'),
      pexels('825661'),
      pexels('2619967'),
    ],
  },
  {
    category: 'Lẩu',
    restaurantIds: [1031, 1032, 1033, 1034, 1035],
    sources: [
      pexels('11089809'),
      pexels('6063231'),
      pexels('24038061'),
      pexels('15026917'),
      pexels('76093'),
    ],
  },
  {
    category: 'Chay',
    restaurantIds: [1036, 1037, 1038, 1039, 1040],
    sources: [
      pexels('5622215'),
      pexels('1640770'),
      pexels('1640774'),
      pexels('1640777'),
      pexels('1640773'),
    ],
  },
]

async function download(url, target) {
  const response = await fetch(url, {
    headers: {
      'user-agent': 'FoodHub local asset downloader',
      accept: 'image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8',
    },
  })
  if (!response.ok) {
    throw new Error(`${response.status} ${response.statusText}: ${url}`)
  }
  const buffer = Buffer.from(await response.arrayBuffer())
  if (buffer.length < 10_000) {
    throw new Error(`Downloaded file is too small: ${url}`)
  }
  await fs.writeFile(target, buffer)
  return buffer.length
}

await fs.mkdir(outputDir, { recursive: true })

const manifest = []
for (const pool of pools) {
  let sourceIndex = 0
  for (const restaurantId of pool.restaurantIds) {
    for (let foodOffset = 1; foodOffset <= 4; foodOffset += 1) {
      const foodId = `${restaurantId}${foodOffset}`
      const source = pool.sources[sourceIndex % pool.sources.length]
      const file = `${foodId}.jpg`
      const target = path.join(outputDir, file)
      const bytes = await download(source, target)
      manifest.push({
        foodId: Number(foodId),
        category: pool.category,
        file: `/images/foods/${file}`,
        source,
        bytes,
      })
      sourceIndex += 1
    }
  }
}

await fs.writeFile(
  path.join(outputDir, 'pexels-food-images.json'),
  `${JSON.stringify(manifest, null, 2)}\n`,
  'utf8',
)

console.log(`Downloaded ${manifest.length} Pexels food images to ${outputDir}`)
