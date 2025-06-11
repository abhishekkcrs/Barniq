import os
import requests
from pathlib import Path

# Create base directory for images
BASE_DIR = Path('assets/images')
BASE_DIR.mkdir(parents=True, exist_ok=True)

# Image URLs for each category
IMAGE_URLS = {
    'groceries': {
        'flour.jpg': 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=500&q=80',
        'rice.jpg': 'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=500&q=80',
        'pulses.jpg': 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=500&q=80'
    },
    'beauty': {
        'skincare.jpg': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=500&q=80',
        'haircare.jpg': 'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=500&q=80',
        'makeup.jpg': 'https://images.unsplash.com/photo-1487412947147-5cebf1000dcd?w=500&q=80'
    },
    'medicines': {
        'tablets.jpg': 'https://images.unsplash.com/photo-1585435557343-3b092092a831?w=500&q=80',
        'syrups.jpg': 'https://images.unsplash.com/photo-1585435557343-3b092092a831?w=500&q=80',
        'healthcare.jpg': 'https://images.unsplash.com/photo-1585435557343-3b092092a831?w=500&q=80'
    },
    'clothes': {
        'casual.jpg': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&q=80',
        'formal.jpg': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&q=80',
        'accessories.jpg': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&q=80'
    },
    'food': {
        'ready_to_eat.jpg': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500&q=80',
        'snacks.jpg': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500&q=80',
        'meals.jpg': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500&q=80'
    },
    'milk': {
        'fresh_milk.jpg': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=500&q=80',
        'curd.jpg': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=500&q=80',
        'butter.jpg': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=500&q=80'
    },
    'bread': {
        'white_bread.jpg': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500&q=80',
        'brown_bread.jpg': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500&q=80',
        'buns.jpg': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500&q=80'
    },
    'eggs': {
        'fresh_eggs.jpg': 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=500&q=80',
        'boiled_eggs.jpg': 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=500&q=80',
        'egg_products.jpg': 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=500&q=80'
    },
    'organic': {
        'vegetables.jpg': 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=500&q=80',
        'fruits.jpg': 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=500&q=80',
        'grains.jpg': 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=500&q=80'
    },
    'smart_devices': {
        'wearables.jpg': 'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=500&q=80',
        'home_automation.jpg': 'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=500&q=80',
        'accessories.jpg': 'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=500&q=80'
    },
    'fitness': {
        'equipment.jpg': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500&q=80',
        'accessories.jpg': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500&q=80',
        'supplements.jpg': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500&q=80'
    },
    'home_decor': {
        'furniture.jpg': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=500&q=80',
        'lighting.jpg': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=500&q=80',
        'accessories.jpg': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=500&q=80'
    },
    'fruits': {
        'fresh_fruits.jpg': 'https://images.unsplash.com/photo-1619566633868-43f52c4d4f5c?w=500&q=80',
        'seasonal.jpg': 'https://images.unsplash.com/photo-1619566633868-43f52c4d4f5c?w=500&q=80',
        'exotic.jpg': 'https://images.unsplash.com/photo-1619566633868-43f52c4d4f5c?w=500&q=80'
    },
    'dry_fruits': {
        'nuts.jpg': 'https://images.unsplash.com/photo-1599707367072-cd6ada2bc375?w=500&q=80',
        'seeds.jpg': 'https://images.unsplash.com/photo-1599707367072-cd6ada2bc375?w=500&q=80',
        'mix.jpg': 'https://images.unsplash.com/photo-1599707367072-cd6ada2bc375?w=500&q=80'
    },
    'milk_products': {
        'paneer.jpg': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=500&q=80',
        'curd.jpg': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=500&q=80',
        'ghee.jpg': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=500&q=80'
    },
    'grains': {
        'rice.jpg': 'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=500&q=80',
        'wheat.jpg': 'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=500&q=80',
        'millets.jpg': 'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=500&q=80'
    }
}

def download_image(url, filepath):
    """Download an image from URL and save it to filepath."""
    try:
        response = requests.get(url, stream=True)
        response.raise_for_status()
        
        with open(filepath, 'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                if chunk:
                    f.write(chunk)
        print(f"✓ Downloaded: {filepath}")
        return True
    except Exception as e:
        print(f"✗ Failed to download {filepath}: {str(e)}")
        return False

def main():
    """Main function to download all images."""
    print("Starting image downloads...")
    
    for category, images in IMAGE_URLS.items():
        # Create category directory
        category_dir = BASE_DIR / category
        category_dir.mkdir(exist_ok=True)
        
        print(f"\nProcessing category: {category}")
        for filename, url in images.items():
            filepath = category_dir / filename
            download_image(url, filepath)
    
    print("\nDownload process completed!")

if __name__ == "__main__":
    main() 