<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DataSet extends Model
{
    use HasFactory;
    // protected $table = 'dataset';
    // protected $primaryKey = 'no';
    // protected $fillable = [
    //     'id_str',
    //     'Label_pakar',
    // ];

    protected $table = 'all_data_sets';

    protected $fillable = [
        'id_str', 'clean_text',
        'quote_count',
        'reply_count',
        'retweet_count',
        'favorite_count',
        'lang',
        'user_id_str',
        'conversation_id_str',
        'username',
        'tweet_url',
        'Label',
        'created_at',
    ];
}
