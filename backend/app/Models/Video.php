<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class Video extends Model
{
    protected $fillable = [
        'title', 'description', 'genre',
        'duration_minutes', 'thumbnail_url',
        'video_url', 'rating', 'album_number'
    ];

    public function watchHistories()
    {
        return $this->hasMany(WatchHistory::class);
    }

    public function watchlists()
    {
        return $this->hasMany(Watchlist::class);
    }
}