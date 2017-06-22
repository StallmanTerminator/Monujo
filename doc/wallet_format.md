# header

| offset | size  | content                       |
|--------|-------|-------------------------------|
| 0-2    | 3     | Magic `MJO`                   |
| 3      | 1     | Wallet version `0x1`          |
| 4      | 1     | `0x0` Normal, `0x1` Encrypted |

# Data

## Normal

| offset | size  | content                          |
|--------|-------|----------------------------------|
| 5-36   | 32    | seed                             |

## Encrypted

**AES-GCM is used to encrypt wallet**

| offset | size  | content            |
|--------|-------|--------------------|
| 5-16   | 12    | nonce              |
| 17- 48 | 32    | encrypted seed     |
| 49-64  | 16    | authentication tag |

