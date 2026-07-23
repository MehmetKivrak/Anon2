<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ShortLink;
use App\Support\Base62;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class ShortLinkController extends Controller
{
    public function index()
    {
        $links = Cache::remember('short_links_all', 60, function () {
            return ShortLink::all()->toArray();
        });
        return response()->json(['success' => true, 'data' => $links], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'original_url' => 'required|url|max:2048',
            'album_number' => 'required|string',
        ]);

        $link = ShortLink::create([
            'original_url' => $validated['original_url'],
            'album_number' => $validated['album_number'],
            'short_code'   => 'temp',
        ]);

        $link->short_code = Base62::encode($link->id);
        $link->save();

        Cache::forget('short_links_all');

        return response()->json(['success' => true, 'data' => $link], 201);
    }

    public function show($id)
    {
        $link = ShortLink::findOrFail($id);
        return response()->json(['success' => true, 'data' => $link], 200);
    }
}