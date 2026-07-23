<?php

namespace Database\Seeders;

use App\Models\Restaurant;
use Illuminate\Database\Seeder;

class RestaurantSeeder extends Seeder
{
    public function run(): void
    {
        $restaurants = [
            ['name' => 'Warsaw Grill House',   'category' => 'Steakhouse', 'latitude' => 52.2297, 'longitude' => 21.0122, 'rating' => 4.5],
            ['name' => 'Krakow Pierogi Bar',    'category' => 'Polish',     'latitude' => 50.0647, 'longitude' => 19.9450, 'rating' => 4.7],
            ['name' => 'Gdansk Seafood House',  'category' => 'Seafood',    'latitude' => 54.3520, 'longitude' => 18.6466, 'rating' => 4.3],
            ['name' => 'Wroclaw Sushi Spot',    'category' => 'Japanese',   'latitude' => 51.1079, 'longitude' => 17.0385, 'rating' => 4.6],
            ['name' => 'Poznan Pizza Corner',   'category' => 'Italian',    'latitude' => 52.4064, 'longitude' => 16.9252, 'rating' => 4.2],
            ['name' => 'Lodz Burger Joint',     'category' => 'Fast Food',  'latitude' => 51.7592, 'longitude' => 19.4550, 'rating' => 4.0],
            ['name' => 'Lublin Vegan Kitchen',  'category' => 'Vegan',      'latitude' => 51.2465, 'longitude' => 22.5684, 'rating' => 4.8],
            ['name' => 'Szczecin Cafe & Bakery','category' => 'Cafe',       'latitude' => 53.4285, 'longitude' => 14.5528, 'rating' => 4.4],
            ['name' => 'Katowice BBQ Smokehouse','category' => 'BBQ',       'latitude' => 50.2649, 'longitude' => 19.0238, 'rating' => 4.1],
            ['name' => 'Bydgoszcz Noodle Bar',  'category' => 'Asian',      'latitude' => 53.1235, 'longitude' => 18.0084, 'rating' => 4.5],
            ['name' => 'Warsaw Curry Palace',   'category' => 'Indian',     'latitude' => 52.2370, 'longitude' => 21.0175, 'rating' => 4.6],
        ];

        foreach ($restaurants as $restaurant) {
            Restaurant::firstOrCreate(
                ['name' => $restaurant['name']],
                array_merge($restaurant, ['album_number' => '78883'])
            );
        }
    }
}