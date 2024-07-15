<?php

namespace App\Http\Controllers;

use App\Models\User;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    public function login(Request $req)
    {
        $user = User::where('email', $req->email)->first();
        if ($user && Hash::check($req->password, $user->password)) {
            $token = $user->createToken('Personal Token')->plainTextToken;
            $res = [
                'success' => true,
                'status' => 200,
                'token' => $token,
                'message' => 'Login Sukses!',
                'data' => $user
            ];
            return response()->json($res);
        } elseif (!$user) {
            $res = [
                'success' => false,
                'status' => 400,
                'message' => 'Akun Tidak ditemukan!',
            ];
            return response()->json($res);
        } else {
            $res = [
                'success' => false,
                'status' => 500,
                'message' => 'Email atau password salah!',
            ];
            return response()->json($res);
        }
    }

    public function register(Request $req)
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

    public function index()
    {
        $koneksi = DB::connection("mysql")->table("users")->select('id', 'name', 'email')->get();
        return response()->json($koneksi, 200);
    }

    public function show($id)
    {
        $user = DB::connection("mysql")->table("users")->find($id);
        if ($user == NULL){
            return response()->json("data pada id=$id, tidak ada!",404);
        }else{
            return response()->json($user,200);
        }
    }
}
