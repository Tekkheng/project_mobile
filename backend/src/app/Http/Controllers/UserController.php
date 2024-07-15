<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $koneksi = DB::connection("mysql")->table("users")->select('id', 'name','email')->get();
        return response()->json($koneksi, 200);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $req)
    {
        try {
            $validasi = Validator::make(
                $req->all(),
                [
                    'name' => 'required|string|max:255',
                    'email' => 'required|email|unique:users',
                    'password' => 'required|string|min:8',
                ],
            );
            if ($validasi->fails()) {
                return response()->json($validasi->errors(), 422);
            }
            $credential = new User();
            $credential->name = $req->name;
            $credential->email = $req->email;
            $credential->password = Hash::make($req->password);
            $credential->save();
            $response = [
                'status' => 200,
                'message' => 'register success',
                'data' => $credential,
            ];
            return response()->json($response);
        } catch (\Throwable $th) {
            $response = ['status' => 500, 'message' => $th];
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(User $user)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(User $user)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, User $user)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        //
    }
}
