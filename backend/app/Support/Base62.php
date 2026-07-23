<?php

namespace App\Support;

class Base62
{
    private const ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

    public static function encode(int $number): string
    {
        if ($number === 0) {
            return self::ALPHABET[0];
        }

        $base = strlen(self::ALPHABET);
        $encoded = '';

        while ($number > 0) {
            $encoded = self::ALPHABET[$number % $base] . $encoded;
            $number = intdiv($number, $base);
        }

        return $encoded;
    }
}