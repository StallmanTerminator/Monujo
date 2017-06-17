(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

UNIT sodium;

{$mode objfpc}{$H+}
{$linklib c}
{$linklib sodium}

INTERFACE

USES    CTypes, sysutils;

FUNCTION crypto_sign_seed_keypair(pk: PChar; sk: PChar; seed: PChar): ctypes.cint; CDECL; EXTERNAL;

FUNCTION crypto_hash_sha256(out_buff: PChar; in_buff: PChar; len: ctypes.culonglong): ctypes.cint; CDECL; EXTERNAL;

IMPLEMENTATION
END.
