<?php

namespace App\Http\Controllers;

use App\Models\ShortLink;

class RedirectController extends Controller
{
    public function redirect($code)
    {
        $link = ShortLink::where('short_code', $code)->firstOrFail();
        $link->increment('click_count');
        return redirect()->away($link->original_url);
    }
}