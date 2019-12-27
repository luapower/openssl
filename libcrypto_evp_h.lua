local ffi = require'ffi'
--[[
// csrc/openssl/src/include/openssl/evp.h
enum {
	EVP_MAX_MD_SIZE      = 64,
	EVP_MAX_KEY_LENGTH   = 64,
	EVP_MAX_IV_LENGTH    = 16,
	EVP_MAX_BLOCK_LENGTH = 32,
	PKCS5_SALT_LEN       = 8,
	PKCS5_DEFAULT_ITER   = 2048,
	EVP_PK_RSA           = 0x0001,
	EVP_PK_DSA           = 0x0002,
	EVP_PK_DH            = 0x0004,
	EVP_PK_EC            = 0x0008,
	EVP_PKT_SIGN         = 0x0010,
	EVP_PKT_ENC          = 0x0020,
	EVP_PKT_EXCH         = 0x0040,
	EVP_PKS_RSA          = 0x0100,
	EVP_PKS_DSA          = 0x0200,
	EVP_PKS_EC           = 0x0400,
	EVP_PKEY_NONE        = NID_undef,
	EVP_PKEY_RSA         = NID_rsaEncryption,
	EVP_PKEY_RSA2        = NID_rsa,
	EVP_PKEY_RSA_PSS     = NID_rsassaPss,
	EVP_PKEY_DSA         = NID_dsa,
	EVP_PKEY_DSA1        = NID_dsa_2,
	EVP_PKEY_DSA2        = NID_dsaWithSHA,
	EVP_PKEY_DSA3        = NID_dsaWithSHA1,
	EVP_PKEY_DSA4        = NID_dsaWithSHA1_2,
	EVP_PKEY_DH          = NID_dhKeyAgreement,
	EVP_PKEY_DHX         = NID_dhpublicnumber,
	EVP_PKEY_EC          = NID_X9_62_id_ecPublicKey,
	EVP_PKEY_SM2         = NID_sm2,
	EVP_PKEY_HMAC        = NID_hmac,
	EVP_PKEY_CMAC        = NID_cmac,
	EVP_PKEY_SCRYPT      = NID_id_scrypt,
	EVP_PKEY_TLS1_PRF    = NID_tls1_prf,
	EVP_PKEY_HKDF        = NID_hkdf,
	EVP_PKEY_POLY1305    = NID_poly1305,
	EVP_PKEY_SIPHASH     = NID_siphash,
	EVP_PKEY_X25519      = NID_X25519,
	EVP_PKEY_ED25519     = NID_ED25519,
	EVP_PKEY_X448        = NID_X448,
	EVP_PKEY_ED448       = NID_ED448,
	EVP_PKEY_MO_SIGN     = 0x0001,
	EVP_PKEY_MO_VERIFY   = 0x0002,
	EVP_PKEY_MO_ENCRYPT  = 0x0004,
	EVP_PKEY_MO_DECRYPT  = 0x0008,
};
EVP_MD *EVP_MD_meth_new(int md_type, int pkey_type);
EVP_MD *EVP_MD_meth_dup(const EVP_MD *md);
void EVP_MD_meth_free(EVP_MD *md);
int EVP_MD_meth_set_input_blocksize(EVP_MD *md, int blocksize);
int EVP_MD_meth_set_result_size(EVP_MD *md, int resultsize);
int EVP_MD_meth_set_app_datasize(EVP_MD *md, int datasize);
int EVP_MD_meth_set_flags(EVP_MD *md, unsigned long flags);
int EVP_MD_meth_set_init(EVP_MD *md, int (*init)(EVP_MD_CTX *ctx));
int EVP_MD_meth_set_update(EVP_MD *md, int (*update)(EVP_MD_CTX *ctx,
                                                     const void *data,
                                                     size_t count));
int EVP_MD_meth_set_final(EVP_MD *md, int (*final)(EVP_MD_CTX *ctx,
                                                   unsigned char *md));
int EVP_MD_meth_set_copy(EVP_MD *md, int (*copy)(EVP_MD_CTX *to,
                                                 const EVP_MD_CTX *from));
int EVP_MD_meth_set_cleanup(EVP_MD *md, int (*cleanup)(EVP_MD_CTX *ctx));
int EVP_MD_meth_set_ctrl(EVP_MD *md, int (*ctrl)(EVP_MD_CTX *ctx, int cmd,
                                                 int p1, void *p2));
int EVP_MD_meth_get_input_blocksize(const EVP_MD *md);
int EVP_MD_meth_get_result_size(const EVP_MD *md);
int EVP_MD_meth_get_app_datasize(const EVP_MD *md);
unsigned long EVP_MD_meth_get_flags(const EVP_MD *md);
int (*EVP_MD_meth_get_init(const EVP_MD *md))(EVP_MD_CTX *ctx);
int (*EVP_MD_meth_get_update(const EVP_MD *md))(EVP_MD_CTX *ctx,
                                                const void *data,
                                                size_t count);
int (*EVP_MD_meth_get_final(const EVP_MD *md))(EVP_MD_CTX *ctx,
                                               unsigned char *md);
int (*EVP_MD_meth_get_copy(const EVP_MD *md))(EVP_MD_CTX *to,
                                              const EVP_MD_CTX *from);
int (*EVP_MD_meth_get_cleanup(const EVP_MD *md))(EVP_MD_CTX *ctx);
int (*EVP_MD_meth_get_ctrl(const EVP_MD *md))(EVP_MD_CTX *ctx, int cmd,
                                              int p1, void *p2);
enum {
	EVP_MD_FLAG_ONESHOT  = 0x0001,
	EVP_MD_FLAG_XOF      = 0x0002,
	EVP_MD_FLAG_DIGALGID_MASK = 0x0018,
	EVP_MD_FLAG_DIGALGID_NULL = 0x0000,
	EVP_MD_FLAG_DIGALGID_ABSENT = 0x0008,
	EVP_MD_FLAG_DIGALGID_CUSTOM = 0x0018,
	EVP_MD_FLAG_FIPS     = 0x0400,
	EVP_MD_CTRL_DIGALGID = 0x1,
	EVP_MD_CTRL_MICALG   = 0x2,
	EVP_MD_CTRL_XOF_LEN  = 0x3,
	EVP_MD_CTRL_ALG_CTRL = 0x1000,
	EVP_MD_CTX_FLAG_ONESHOT = 0x0001,
	EVP_MD_CTX_FLAG_CLEANED = 0x0002,
	EVP_MD_CTX_FLAG_REUSE = 0x0004,
	EVP_MD_CTX_FLAG_NON_FIPS_ALLOW = 0x0008,
	EVP_MD_CTX_FLAG_PAD_MASK = 0xF0,
	EVP_MD_CTX_FLAG_PAD_PKCS1 = 0x00,
	EVP_MD_CTX_FLAG_PAD_X931 = 0x10,
	EVP_MD_CTX_FLAG_PAD_PSS = 0x20,
	EVP_MD_CTX_FLAG_NO_INIT = 0x0100,
	EVP_MD_CTX_FLAG_FINALISE = 0x0200,
};
EVP_CIPHER *EVP_CIPHER_meth_new(int cipher_type, int block_size, int key_len);
EVP_CIPHER *EVP_CIPHER_meth_dup(const EVP_CIPHER *cipher);
void EVP_CIPHER_meth_free(EVP_CIPHER *cipher);
int EVP_CIPHER_meth_set_iv_length(EVP_CIPHER *cipher, int iv_len);
int EVP_CIPHER_meth_set_flags(EVP_CIPHER *cipher, unsigned long flags);
int EVP_CIPHER_meth_set_impl_ctx_size(EVP_CIPHER *cipher, int ctx_size);
int EVP_CIPHER_meth_set_init(EVP_CIPHER *cipher,
                             int (*init) (EVP_CIPHER_CTX *ctx,
                                          const unsigned char *key,
                                          const unsigned char *iv,
                                          int enc));
int EVP_CIPHER_meth_set_do_cipher(EVP_CIPHER *cipher,
                                  int (*do_cipher) (EVP_CIPHER_CTX *ctx,
                                                    unsigned char *out,
                                                    const unsigned char *in,
                                                    size_t inl));
int EVP_CIPHER_meth_set_cleanup(EVP_CIPHER *cipher,
                                int (*cleanup) (EVP_CIPHER_CTX *));
int EVP_CIPHER_meth_set_set_asn1_params(EVP_CIPHER *cipher,
                                        int (*set_asn1_parameters) (EVP_CIPHER_CTX *,
                                                                    ASN1_TYPE *));
int EVP_CIPHER_meth_set_get_asn1_params(EVP_CIPHER *cipher,
                                        int (*get_asn1_parameters) (EVP_CIPHER_CTX *,
                                                                    ASN1_TYPE *));
int EVP_CIPHER_meth_set_ctrl(EVP_CIPHER *cipher,
                             int (*ctrl) (EVP_CIPHER_CTX *, int type,
                                          int arg, void *ptr));
int (*EVP_CIPHER_meth_get_init(const EVP_CIPHER *cipher))(EVP_CIPHER_CTX *ctx,
                                                          const unsigned char *key,
                                                          const unsigned char *iv,
                                                          int enc);
int (*EVP_CIPHER_meth_get_do_cipher(const EVP_CIPHER *cipher))(EVP_CIPHER_CTX *ctx,
                                                               unsigned char *out,
                                                               const unsigned char *in,
                                                               size_t inl);
int (*EVP_CIPHER_meth_get_cleanup(const EVP_CIPHER *cipher))(EVP_CIPHER_CTX *);
int (*EVP_CIPHER_meth_get_set_asn1_params(const EVP_CIPHER *cipher))(EVP_CIPHER_CTX *,
                                                                     ASN1_TYPE *);
int (*EVP_CIPHER_meth_get_get_asn1_params(const EVP_CIPHER *cipher))(EVP_CIPHER_CTX *,
                                                               ASN1_TYPE *);
int (*EVP_CIPHER_meth_get_ctrl(const EVP_CIPHER *cipher))(EVP_CIPHER_CTX *,
                                                          int type, int arg,
                                                          void *ptr);
enum {
	EVP_CIPH_STREAM_CIPHER = 0x0,
	EVP_CIPH_ECB_MODE    = 0x1,
	EVP_CIPH_CBC_MODE    = 0x2,
	EVP_CIPH_CFB_MODE    = 0x3,
	EVP_CIPH_OFB_MODE    = 0x4,
	EVP_CIPH_CTR_MODE    = 0x5,
	EVP_CIPH_GCM_MODE    = 0x6,
	EVP_CIPH_CCM_MODE    = 0x7,
	EVP_CIPH_XTS_MODE    = 0x10001,
	EVP_CIPH_WRAP_MODE   = 0x10002,
	EVP_CIPH_OCB_MODE    = 0x10003,
	EVP_CIPH_MODE        = 0xF0007,
	EVP_CIPH_VARIABLE_LENGTH = 0x8,
	EVP_CIPH_CUSTOM_IV   = 0x10,
	EVP_CIPH_ALWAYS_CALL_INIT = 0x20,
	EVP_CIPH_CTRL_INIT   = 0x40,
	EVP_CIPH_CUSTOM_KEY_LENGTH = 0x80,
	EVP_CIPH_NO_PADDING  = 0x100,
	EVP_CIPH_RAND_KEY    = 0x200,
	EVP_CIPH_CUSTOM_COPY = 0x400,
	EVP_CIPH_CUSTOM_IV_LENGTH = 0x800,
	EVP_CIPH_FLAG_DEFAULT_ASN1 = 0x1000,
	EVP_CIPH_FLAG_LENGTH_BITS = 0x2000,
	EVP_CIPH_FLAG_FIPS   = 0x4000,
	EVP_CIPH_FLAG_NON_FIPS_ALLOW = 0x8000,
	EVP_CIPH_FLAG_CUSTOM_CIPHER = 0x100000,
	EVP_CIPH_FLAG_AEAD_CIPHER = 0x200000,
	EVP_CIPH_FLAG_TLS1_1_MULTIBLOCK = 0x400000,
	EVP_CIPH_FLAG_PIPELINE = 0X800000,
	EVP_CIPHER_CTX_FLAG_WRAP_ALLOW = 0x1,
	EVP_CTRL_INIT        = 0x0,
	EVP_CTRL_SET_KEY_LENGTH = 0x1,
	EVP_CTRL_GET_RC2_KEY_BITS = 0x2,
	EVP_CTRL_SET_RC2_KEY_BITS = 0x3,
	EVP_CTRL_GET_RC5_ROUNDS = 0x4,
	EVP_CTRL_SET_RC5_ROUNDS = 0x5,
	EVP_CTRL_RAND_KEY    = 0x6,
	EVP_CTRL_PBE_PRF_NID = 0x7,
	EVP_CTRL_COPY        = 0x8,
	EVP_CTRL_AEAD_SET_IVLEN = 0x9,
	EVP_CTRL_AEAD_GET_TAG = 0x10,
	EVP_CTRL_AEAD_SET_TAG = 0x11,
	EVP_CTRL_AEAD_SET_IV_FIXED = 0x12,
	EVP_CTRL_GCM_SET_IVLEN = EVP_CTRL_AEAD_SET_IVLEN,
	EVP_CTRL_GCM_GET_TAG = EVP_CTRL_AEAD_GET_TAG,
	EVP_CTRL_GCM_SET_TAG = EVP_CTRL_AEAD_SET_TAG,
	EVP_CTRL_GCM_SET_IV_FIXED = EVP_CTRL_AEAD_SET_IV_FIXED,
	EVP_CTRL_GCM_IV_GEN  = 0x13,
	EVP_CTRL_CCM_SET_IVLEN = EVP_CTRL_AEAD_SET_IVLEN,
	EVP_CTRL_CCM_GET_TAG = EVP_CTRL_AEAD_GET_TAG,
	EVP_CTRL_CCM_SET_TAG = EVP_CTRL_AEAD_SET_TAG,
	EVP_CTRL_CCM_SET_IV_FIXED = EVP_CTRL_AEAD_SET_IV_FIXED,
	EVP_CTRL_CCM_SET_L   = 0x14,
	EVP_CTRL_CCM_SET_MSGLEN = 0x15,
	EVP_CTRL_AEAD_TLS1_AAD = 0x16,
	EVP_CTRL_AEAD_SET_MAC_KEY = 0x17,
	EVP_CTRL_GCM_SET_IV_INV = 0x18,
	EVP_CTRL_TLS1_1_MULTIBLOCK_AAD = 0x19,
	EVP_CTRL_TLS1_1_MULTIBLOCK_ENCRYPT = 0x1a,
	EVP_CTRL_TLS1_1_MULTIBLOCK_DECRYPT = 0x1b,
	EVP_CTRL_TLS1_1_MULTIBLOCK_MAX_BUFSIZE = 0x1c,
	EVP_CTRL_SSL3_MASTER_SECRET = 0x1d,
	EVP_CTRL_SET_SBOX    = 0x1e,
	EVP_CTRL_SBOX_USED   = 0x1f,
	EVP_CTRL_KEY_MESH    = 0x20,
	EVP_CTRL_BLOCK_PADDING_MODE = 0x21,
	EVP_CTRL_SET_PIPELINE_OUTPUT_BUFS = 0x22,
	EVP_CTRL_SET_PIPELINE_INPUT_BUFS = 0x23,
	EVP_CTRL_SET_PIPELINE_INPUT_LENS = 0x24,
	EVP_CTRL_GET_IVLEN   = 0x25,
	EVP_PADDING_PKCS7    = 1,
	EVP_PADDING_ISO7816_4 = 2,
	EVP_PADDING_ANSI923  = 3,
	EVP_PADDING_ISO10126 = 4,
	EVP_PADDING_ZERO     = 5,
	EVP_AEAD_TLS1_AAD_LEN = 13,
};
typedef struct {
    unsigned char *out;
    const unsigned char *inp;
    size_t len;
    unsigned int interleave;
} EVP_CTRL_TLS1_1_MULTIBLOCK_PARAM;
enum {
	EVP_GCM_TLS_FIXED_IV_LEN = 4,
	EVP_GCM_TLS_EXPLICIT_IV_LEN = 8,
	EVP_GCM_TLS_TAG_LEN  = 16,
	EVP_CCM_TLS_FIXED_IV_LEN = 4,
	EVP_CCM_TLS_EXPLICIT_IV_LEN = 8,
	EVP_CCM_TLS_IV_LEN   = 12,
	EVP_CCM_TLS_TAG_LEN  = 16,
	EVP_CCM8_TLS_TAG_LEN = 8,
	EVP_CHACHAPOLY_TLS_TAG_LEN = 16,
};
typedef struct evp_cipher_info_st {
    const EVP_CIPHER *cipher;
    unsigned char iv[16];
} EVP_CIPHER_INFO;
typedef int (EVP_PBE_KEYGEN) (EVP_CIPHER_CTX *ctx, const char *pass,
                              int passlen, ASN1_TYPE *param,
                              const EVP_CIPHER *cipher, const EVP_MD *md,
                              int en_de);
#define EVP_PKEY_assign_RSA(pkey,rsa) EVP_PKEY_assign((pkey),EVP_PKEY_RSA, (char *)(rsa))
#define EVP_PKEY_assign_DSA(pkey,dsa) EVP_PKEY_assign((pkey),EVP_PKEY_DSA, (char *)(dsa))
#define EVP_PKEY_assign_DH(pkey,dh) EVP_PKEY_assign((pkey),EVP_PKEY_DH, (char *)(dh))
#define EVP_PKEY_assign_EC_KEY(pkey,eckey) EVP_PKEY_assign((pkey),EVP_PKEY_EC, (char *)(eckey))
#define EVP_PKEY_assign_SIPHASH(pkey,shkey) EVP_PKEY_assign((pkey),EVP_PKEY_SIPHASH, (char *)(shkey))
#define EVP_PKEY_assign_POLY1305(pkey,polykey) EVP_PKEY_assign((pkey),EVP_PKEY_POLY1305, (char *)(polykey))
#define EVP_get_digestbynid(a) EVP_get_digestbyname(OBJ_nid2sn(a))
#define EVP_get_digestbyobj(a) EVP_get_digestbynid(OBJ_obj2nid(a))
#define EVP_get_cipherbynid(a) EVP_get_cipherbyname(OBJ_nid2sn(a))
#define EVP_get_cipherbyobj(a) EVP_get_cipherbynid(OBJ_obj2nid(a))
int EVP_MD_type(const EVP_MD *md);
#define EVP_MD_nid(e) EVP_MD_type(e)
#define EVP_MD_name(e) OBJ_nid2sn(EVP_MD_nid(e))
int EVP_MD_pkey_type(const EVP_MD *md);
int EVP_MD_size(const EVP_MD *md);
int EVP_MD_block_size(const EVP_MD *md);
unsigned long EVP_MD_flags(const EVP_MD *md);
const EVP_MD *EVP_MD_CTX_md(const EVP_MD_CTX *ctx);
int (*EVP_MD_CTX_update_fn(EVP_MD_CTX *ctx))(EVP_MD_CTX *ctx,
                                             const void *data, size_t count);
void EVP_MD_CTX_set_update_fn(EVP_MD_CTX *ctx,
                              int (*update) (EVP_MD_CTX *ctx,
                                             const void *data, size_t count));
#define EVP_MD_CTX_size(e) EVP_MD_size(EVP_MD_CTX_md(e))
#define EVP_MD_CTX_block_size(e) EVP_MD_block_size(EVP_MD_CTX_md(e))
#define EVP_MD_CTX_type(e) EVP_MD_type(EVP_MD_CTX_md(e))
EVP_PKEY_CTX *EVP_MD_CTX_pkey_ctx(const EVP_MD_CTX *ctx);
void EVP_MD_CTX_set_pkey_ctx(EVP_MD_CTX *ctx, EVP_PKEY_CTX *pctx);
void *EVP_MD_CTX_md_data(const EVP_MD_CTX *ctx);
int EVP_CIPHER_nid(const EVP_CIPHER *cipher);
#define EVP_CIPHER_name(e) OBJ_nid2sn(EVP_CIPHER_nid(e))
int EVP_CIPHER_block_size(const EVP_CIPHER *cipher);
int EVP_CIPHER_impl_ctx_size(const EVP_CIPHER *cipher);
int EVP_CIPHER_key_length(const EVP_CIPHER *cipher);
int EVP_CIPHER_iv_length(const EVP_CIPHER *cipher);
unsigned long EVP_CIPHER_flags(const EVP_CIPHER *cipher);
#define EVP_CIPHER_mode(e) (EVP_CIPHER_flags(e) & EVP_CIPH_MODE)
const EVP_CIPHER *EVP_CIPHER_CTX_cipher(const EVP_CIPHER_CTX *ctx);
int EVP_CIPHER_CTX_encrypting(const EVP_CIPHER_CTX *ctx);
int EVP_CIPHER_CTX_nid(const EVP_CIPHER_CTX *ctx);
int EVP_CIPHER_CTX_block_size(const EVP_CIPHER_CTX *ctx);
int EVP_CIPHER_CTX_key_length(const EVP_CIPHER_CTX *ctx);
int EVP_CIPHER_CTX_iv_length(const EVP_CIPHER_CTX *ctx);
const unsigned char *EVP_CIPHER_CTX_iv(const EVP_CIPHER_CTX *ctx);
const unsigned char *EVP_CIPHER_CTX_original_iv(const EVP_CIPHER_CTX *ctx);
unsigned char *EVP_CIPHER_CTX_iv_noconst(EVP_CIPHER_CTX *ctx);
unsigned char *EVP_CIPHER_CTX_buf_noconst(EVP_CIPHER_CTX *ctx);
int EVP_CIPHER_CTX_num(const EVP_CIPHER_CTX *ctx);
void EVP_CIPHER_CTX_set_num(EVP_CIPHER_CTX *ctx, int num);
int EVP_CIPHER_CTX_copy(EVP_CIPHER_CTX *out, const EVP_CIPHER_CTX *in);
void *EVP_CIPHER_CTX_get_app_data(const EVP_CIPHER_CTX *ctx);
void EVP_CIPHER_CTX_set_app_data(EVP_CIPHER_CTX *ctx, void *data);
void *EVP_CIPHER_CTX_get_cipher_data(const EVP_CIPHER_CTX *ctx);
void *EVP_CIPHER_CTX_set_cipher_data(EVP_CIPHER_CTX *ctx, void *cipher_data);
#define EVP_CIPHER_CTX_type(c) EVP_CIPHER_type(EVP_CIPHER_CTX_cipher(c))
#define EVP_CIPHER_CTX_flags(c) EVP_CIPHER_flags(EVP_CIPHER_CTX_cipher(c))
#define EVP_CIPHER_CTX_mode(c) EVP_CIPHER_mode(EVP_CIPHER_CTX_cipher(c))
#define EVP_ENCODE_LENGTH(l) ((((l)+2)/3*4)+((l)/48+1)*2+80)
#define EVP_DECODE_LENGTH(l) (((l)+3)/4*3+80)
#define EVP_SignInit_ex(a,b,c) EVP_DigestInit_ex(a,b,c)
#define EVP_SignInit(a,b) EVP_DigestInit(a,b)
#define EVP_SignUpdate(a,b,c) EVP_DigestUpdate(a,b,c)
#define EVP_VerifyInit_ex(a,b,c) EVP_DigestInit_ex(a,b,c)
#define EVP_VerifyInit(a,b) EVP_DigestInit(a,b)
#define EVP_VerifyUpdate(a,b,c) EVP_DigestUpdate(a,b,c)
#define EVP_OpenUpdate(a,b,c,d,e) EVP_DecryptUpdate(a,b,c,d,e)
#define EVP_SealUpdate(a,b,c,d,e) EVP_EncryptUpdate(a,b,c,d,e)
#define EVP_DigestSignUpdate(a,b,c) EVP_DigestUpdate(a,b,c)
#define EVP_DigestVerifyUpdate(a,b,c) EVP_DigestUpdate(a,b,c)
#define BIO_set_md(b,md) BIO_ctrl(b,BIO_C_SET_MD,0,(char *)(md))
#define BIO_get_md(b,mdp) BIO_ctrl(b,BIO_C_GET_MD,0,(char *)(mdp))
#define BIO_get_md_ctx(b,mdcp) BIO_ctrl(b,BIO_C_GET_MD_CTX,0, (char *)(mdcp))
#define BIO_set_md_ctx(b,mdcp) BIO_ctrl(b,BIO_C_SET_MD_CTX,0, (char *)(mdcp))
#define BIO_get_cipher_status(b) BIO_ctrl(b,BIO_C_GET_CIPHER_STATUS,0,NULL)
#define BIO_get_cipher_ctx(b,c_pp) BIO_ctrl(b,BIO_C_GET_CIPHER_CTX,0, (char *)(c_pp))
           int EVP_Cipher(EVP_CIPHER_CTX *c,
                          unsigned char *out,
                          const unsigned char *in, unsigned int inl);
#define EVP_add_cipher_alias(n,alias) OBJ_NAME_add((alias),OBJ_NAME_TYPE_CIPHER_METH|OBJ_NAME_ALIAS,(n))
#define EVP_add_digest_alias(n,alias) OBJ_NAME_add((alias),OBJ_NAME_TYPE_MD_METH|OBJ_NAME_ALIAS,(n))
#define EVP_delete_cipher_alias(alias) OBJ_NAME_remove(alias,OBJ_NAME_TYPE_CIPHER_METH|OBJ_NAME_ALIAS);
#define EVP_delete_digest_alias(alias) OBJ_NAME_remove(alias,OBJ_NAME_TYPE_MD_METH|OBJ_NAME_ALIAS);
int EVP_MD_CTX_ctrl(EVP_MD_CTX *ctx, int cmd, int p1, void *p2);
EVP_MD_CTX *EVP_MD_CTX_new(void);
int EVP_MD_CTX_reset(EVP_MD_CTX *ctx);
void EVP_MD_CTX_free(EVP_MD_CTX *ctx);
#define EVP_MD_CTX_create() EVP_MD_CTX_new()
#define EVP_MD_CTX_init(ctx) EVP_MD_CTX_reset((ctx))
#define EVP_MD_CTX_destroy(ctx) EVP_MD_CTX_free((ctx))
 int EVP_MD_CTX_copy_ex(EVP_MD_CTX *out, const EVP_MD_CTX *in);
void EVP_MD_CTX_set_flags(EVP_MD_CTX *ctx, int flags);
void EVP_MD_CTX_clear_flags(EVP_MD_CTX *ctx, int flags);
int EVP_MD_CTX_test_flags(const EVP_MD_CTX *ctx, int flags);
 int EVP_DigestInit_ex(EVP_MD_CTX *ctx, const EVP_MD *type,
                                 ENGINE *impl);
 int EVP_DigestUpdate(EVP_MD_CTX *ctx, const void *d,
                                size_t cnt);
 int EVP_DigestFinal_ex(EVP_MD_CTX *ctx, unsigned char *md,
                                  unsigned int *s);
 int EVP_Digest(const void *data, size_t count,
                          unsigned char *md, unsigned int *size,
                          const EVP_MD *type, ENGINE *impl);
 int EVP_MD_CTX_copy(EVP_MD_CTX *out, const EVP_MD_CTX *in);
 int EVP_DigestInit(EVP_MD_CTX *ctx, const EVP_MD *type);
 int EVP_DigestFinal(EVP_MD_CTX *ctx, unsigned char *md,
                           unsigned int *s);
 int EVP_DigestFinalXOF(EVP_MD_CTX *ctx, unsigned char *md,
                              size_t len);
int EVP_read_pw_string(char *buf, int length, const char *prompt, int verify);
int EVP_read_pw_string_min(char *buf, int minlen, int maxlen,
                           const char *prompt, int verify);
void EVP_set_pw_prompt(const char *prompt);
char *EVP_get_pw_prompt(void);
 int EVP_BytesToKey(const EVP_CIPHER *type, const EVP_MD *md,
                          const unsigned char *salt,
                          const unsigned char *data, int datal, int count,
                          unsigned char *key, unsigned char *iv);
void EVP_CIPHER_CTX_set_flags(EVP_CIPHER_CTX *ctx, int flags);
void EVP_CIPHER_CTX_clear_flags(EVP_CIPHER_CTX *ctx, int flags);
int EVP_CIPHER_CTX_test_flags(const EVP_CIPHER_CTX *ctx, int flags);
 int EVP_EncryptInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *cipher,
                           const unsigned char *key, const unsigned char *iv);
           int EVP_EncryptInit_ex(EVP_CIPHER_CTX *ctx,
                                  const EVP_CIPHER *cipher, ENGINE *impl,
                                  const unsigned char *key,
                                  const unsigned char *iv);
           int EVP_EncryptUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out,
                                 int *outl, const unsigned char *in, int inl);
           int EVP_EncryptFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *out,
                                   int *outl);
           int EVP_EncryptFinal(EVP_CIPHER_CTX *ctx, unsigned char *out,
                                int *outl);
 int EVP_DecryptInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *cipher,
                           const unsigned char *key, const unsigned char *iv);
           int EVP_DecryptInit_ex(EVP_CIPHER_CTX *ctx,
                                  const EVP_CIPHER *cipher, ENGINE *impl,
                                  const unsigned char *key,
                                  const unsigned char *iv);
           int EVP_DecryptUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out,
                                 int *outl, const unsigned char *in, int inl);
 int EVP_DecryptFinal(EVP_CIPHER_CTX *ctx, unsigned char *outm,
                            int *outl);
           int EVP_DecryptFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *outm,
                                   int *outl);
 int EVP_CipherInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *cipher,
                          const unsigned char *key, const unsigned char *iv,
                          int enc);
           int EVP_CipherInit_ex(EVP_CIPHER_CTX *ctx,
                                 const EVP_CIPHER *cipher, ENGINE *impl,
                                 const unsigned char *key,
                                 const unsigned char *iv, int enc);
 int EVP_CipherUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out,
                            int *outl, const unsigned char *in, int inl);
 int EVP_CipherFinal(EVP_CIPHER_CTX *ctx, unsigned char *outm,
                           int *outl);
 int EVP_CipherFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *outm,
                              int *outl);
 int EVP_SignFinal(EVP_MD_CTX *ctx, unsigned char *md, unsigned int *s,
                         EVP_PKEY *pkey);
 int EVP_DigestSign(EVP_MD_CTX *ctx, unsigned char *sigret,
                          size_t *siglen, const unsigned char *tbs,
                          size_t tbslen);
 int EVP_VerifyFinal(EVP_MD_CTX *ctx, const unsigned char *sigbuf,
                           unsigned int siglen, EVP_PKEY *pkey);
 int EVP_DigestVerify(EVP_MD_CTX *ctx, const unsigned char *sigret,
                            size_t siglen, const unsigned char *tbs,
                            size_t tbslen);
           int EVP_DigestSignInit(EVP_MD_CTX *ctx, EVP_PKEY_CTX **pctx,
                                  const EVP_MD *type, ENGINE *e,
                                  EVP_PKEY *pkey);
 int EVP_DigestSignFinal(EVP_MD_CTX *ctx, unsigned char *sigret,
                               size_t *siglen);
 int EVP_DigestVerifyInit(EVP_MD_CTX *ctx, EVP_PKEY_CTX **pctx,
                                const EVP_MD *type, ENGINE *e,
                                EVP_PKEY *pkey);
 int EVP_DigestVerifyFinal(EVP_MD_CTX *ctx, const unsigned char *sig,
                                 size_t siglen);
 int EVP_OpenInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type,
                        const unsigned char *ek, int ekl,
                        const unsigned char *iv, EVP_PKEY *priv);
 int EVP_OpenFinal(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl);
 int EVP_SealInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type,
                        unsigned char **ek, int *ekl, unsigned char *iv,
                        EVP_PKEY **pubk, int npubk);
 int EVP_SealFinal(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl);
EVP_ENCODE_CTX *EVP_ENCODE_CTX_new(void);
void EVP_ENCODE_CTX_free(EVP_ENCODE_CTX *ctx);
int EVP_ENCODE_CTX_copy(EVP_ENCODE_CTX *dctx, EVP_ENCODE_CTX *sctx);
int EVP_ENCODE_CTX_num(EVP_ENCODE_CTX *ctx);
void EVP_EncodeInit(EVP_ENCODE_CTX *ctx);
int EVP_EncodeUpdate(EVP_ENCODE_CTX *ctx, unsigned char *out, int *outl,
                     const unsigned char *in, int inl);
void EVP_EncodeFinal(EVP_ENCODE_CTX *ctx, unsigned char *out, int *outl);
int EVP_EncodeBlock(unsigned char *t, const unsigned char *f, int n);
void EVP_DecodeInit(EVP_ENCODE_CTX *ctx);
int EVP_DecodeUpdate(EVP_ENCODE_CTX *ctx, unsigned char *out, int *outl,
                     const unsigned char *in, int inl);
int EVP_DecodeFinal(EVP_ENCODE_CTX *ctx, unsigned
                    char *out, int *outl);
int EVP_DecodeBlock(unsigned char *t, const unsigned char *f, int n);
#define EVP_CIPHER_CTX_init(c) EVP_CIPHER_CTX_reset(c)
#define EVP_CIPHER_CTX_cleanup(c) EVP_CIPHER_CTX_reset(c)
EVP_CIPHER_CTX *EVP_CIPHER_CTX_new(void);
int EVP_CIPHER_CTX_reset(EVP_CIPHER_CTX *c);
void EVP_CIPHER_CTX_free(EVP_CIPHER_CTX *c);
int EVP_CIPHER_CTX_set_key_length(EVP_CIPHER_CTX *x, int keylen);
int EVP_CIPHER_CTX_set_padding(EVP_CIPHER_CTX *c, int pad);
int EVP_CIPHER_CTX_ctrl(EVP_CIPHER_CTX *ctx, int type, int arg, void *ptr);
int EVP_CIPHER_CTX_rand_key(EVP_CIPHER_CTX *ctx, unsigned char *key);
const BIO_METHOD *BIO_f_md(void);
const BIO_METHOD *BIO_f_base64(void);
const BIO_METHOD *BIO_f_cipher(void);
const BIO_METHOD *BIO_f_reliable(void);
 int BIO_set_cipher(BIO *b, const EVP_CIPHER *c, const unsigned char *k,
                          const unsigned char *i, int enc);
const EVP_MD *EVP_md_null(void);
const EVP_MD *EVP_md4(void);
const EVP_MD *EVP_md5(void);
const EVP_MD *EVP_md5_sha1(void);
const EVP_MD *EVP_blake2b512(void);
const EVP_MD *EVP_blake2s256(void);
const EVP_MD *EVP_sha1(void);
const EVP_MD *EVP_sha224(void);
const EVP_MD *EVP_sha256(void);
const EVP_MD *EVP_sha384(void);
const EVP_MD *EVP_sha512(void);
const EVP_MD *EVP_sha512_224(void);
const EVP_MD *EVP_sha512_256(void);
const EVP_MD *EVP_sha3_224(void);
const EVP_MD *EVP_sha3_256(void);
const EVP_MD *EVP_sha3_384(void);
const EVP_MD *EVP_sha3_512(void);
const EVP_MD *EVP_shake128(void);
const EVP_MD *EVP_shake256(void);
const EVP_MD *EVP_mdc2(void);
const EVP_MD *EVP_ripemd160(void);
const EVP_MD *EVP_whirlpool(void);
const EVP_MD *EVP_sm3(void);
const EVP_CIPHER *EVP_enc_null(void);
const EVP_CIPHER *EVP_des_ecb(void);
const EVP_CIPHER *EVP_des_ede(void);
const EVP_CIPHER *EVP_des_ede3(void);
const EVP_CIPHER *EVP_des_ede_ecb(void);
const EVP_CIPHER *EVP_des_ede3_ecb(void);
const EVP_CIPHER *EVP_des_cfb64(void);
enum {
	EVP_des_cfb          = EVP_des_cfb64,
};
const EVP_CIPHER *EVP_des_cfb1(void);
const EVP_CIPHER *EVP_des_cfb8(void);
const EVP_CIPHER *EVP_des_ede_cfb64(void);
enum {
	EVP_des_ede_cfb      = EVP_des_ede_cfb64,
};
const EVP_CIPHER *EVP_des_ede3_cfb64(void);
enum {
	EVP_des_ede3_cfb     = EVP_des_ede3_cfb64,
};
const EVP_CIPHER *EVP_des_ede3_cfb1(void);
const EVP_CIPHER *EVP_des_ede3_cfb8(void);
const EVP_CIPHER *EVP_des_ofb(void);
const EVP_CIPHER *EVP_des_ede_ofb(void);
const EVP_CIPHER *EVP_des_ede3_ofb(void);
const EVP_CIPHER *EVP_des_cbc(void);
const EVP_CIPHER *EVP_des_ede_cbc(void);
const EVP_CIPHER *EVP_des_ede3_cbc(void);
const EVP_CIPHER *EVP_desx_cbc(void);
const EVP_CIPHER *EVP_des_ede3_wrap(void);
const EVP_CIPHER *EVP_rc4(void);
const EVP_CIPHER *EVP_rc4_40(void);
const EVP_CIPHER *EVP_rc4_hmac_md5(void);
const EVP_CIPHER *EVP_idea_ecb(void);
const EVP_CIPHER *EVP_idea_cfb64(void);
enum {
	EVP_idea_cfb         = EVP_idea_cfb64,
};
const EVP_CIPHER *EVP_idea_ofb(void);
const EVP_CIPHER *EVP_idea_cbc(void);
const EVP_CIPHER *EVP_rc2_ecb(void);
const EVP_CIPHER *EVP_rc2_cbc(void);
const EVP_CIPHER *EVP_rc2_40_cbc(void);
const EVP_CIPHER *EVP_rc2_64_cbc(void);
const EVP_CIPHER *EVP_rc2_cfb64(void);
enum {
	EVP_rc2_cfb          = EVP_rc2_cfb64,
};
const EVP_CIPHER *EVP_rc2_ofb(void);
const EVP_CIPHER *EVP_bf_ecb(void);
const EVP_CIPHER *EVP_bf_cbc(void);
const EVP_CIPHER *EVP_bf_cfb64(void);
enum {
	EVP_bf_cfb           = EVP_bf_cfb64,
};
const EVP_CIPHER *EVP_bf_ofb(void);
const EVP_CIPHER *EVP_cast5_ecb(void);
const EVP_CIPHER *EVP_cast5_cbc(void);
const EVP_CIPHER *EVP_cast5_cfb64(void);
enum {
	EVP_cast5_cfb        = EVP_cast5_cfb64,
};
const EVP_CIPHER *EVP_cast5_ofb(void);
const EVP_CIPHER *EVP_aes_128_ecb(void);
const EVP_CIPHER *EVP_aes_128_cbc(void);
const EVP_CIPHER *EVP_aes_128_cfb1(void);
const EVP_CIPHER *EVP_aes_128_cfb8(void);
const EVP_CIPHER *EVP_aes_128_cfb128(void);
enum {
	EVP_aes_128_cfb      = EVP_aes_128_cfb128,
};
const EVP_CIPHER *EVP_aes_128_ofb(void);
const EVP_CIPHER *EVP_aes_128_ctr(void);
const EVP_CIPHER *EVP_aes_128_ccm(void);
const EVP_CIPHER *EVP_aes_128_gcm(void);
const EVP_CIPHER *EVP_aes_128_xts(void);
const EVP_CIPHER *EVP_aes_128_wrap(void);
const EVP_CIPHER *EVP_aes_128_wrap_pad(void);
const EVP_CIPHER *EVP_aes_128_ocb(void);
const EVP_CIPHER *EVP_aes_192_ecb(void);
const EVP_CIPHER *EVP_aes_192_cbc(void);
const EVP_CIPHER *EVP_aes_192_cfb1(void);
const EVP_CIPHER *EVP_aes_192_cfb8(void);
const EVP_CIPHER *EVP_aes_192_cfb128(void);
enum {
	EVP_aes_192_cfb      = EVP_aes_192_cfb128,
};
const EVP_CIPHER *EVP_aes_192_ofb(void);
const EVP_CIPHER *EVP_aes_192_ctr(void);
const EVP_CIPHER *EVP_aes_192_ccm(void);
const EVP_CIPHER *EVP_aes_192_gcm(void);
const EVP_CIPHER *EVP_aes_192_wrap(void);
const EVP_CIPHER *EVP_aes_192_wrap_pad(void);
const EVP_CIPHER *EVP_aes_192_ocb(void);
const EVP_CIPHER *EVP_aes_256_ecb(void);
const EVP_CIPHER *EVP_aes_256_cbc(void);
const EVP_CIPHER *EVP_aes_256_cfb1(void);
const EVP_CIPHER *EVP_aes_256_cfb8(void);
const EVP_CIPHER *EVP_aes_256_cfb128(void);
enum {
	EVP_aes_256_cfb      = EVP_aes_256_cfb128,
};
const EVP_CIPHER *EVP_aes_256_ofb(void);
const EVP_CIPHER *EVP_aes_256_ctr(void);
const EVP_CIPHER *EVP_aes_256_ccm(void);
const EVP_CIPHER *EVP_aes_256_gcm(void);
const EVP_CIPHER *EVP_aes_256_xts(void);
const EVP_CIPHER *EVP_aes_256_wrap(void);
const EVP_CIPHER *EVP_aes_256_wrap_pad(void);
const EVP_CIPHER *EVP_aes_256_ocb(void);
const EVP_CIPHER *EVP_aes_128_cbc_hmac_sha1(void);
const EVP_CIPHER *EVP_aes_256_cbc_hmac_sha1(void);
const EVP_CIPHER *EVP_aes_128_cbc_hmac_sha256(void);
const EVP_CIPHER *EVP_aes_256_cbc_hmac_sha256(void);
const EVP_CIPHER *EVP_aria_128_ecb(void);
const EVP_CIPHER *EVP_aria_128_cbc(void);
const EVP_CIPHER *EVP_aria_128_cfb1(void);
const EVP_CIPHER *EVP_aria_128_cfb8(void);
const EVP_CIPHER *EVP_aria_128_cfb128(void);
enum {
	EVP_aria_128_cfb     = EVP_aria_128_cfb128,
};
const EVP_CIPHER *EVP_aria_128_ctr(void);
const EVP_CIPHER *EVP_aria_128_ofb(void);
const EVP_CIPHER *EVP_aria_128_gcm(void);
const EVP_CIPHER *EVP_aria_128_ccm(void);
const EVP_CIPHER *EVP_aria_192_ecb(void);
const EVP_CIPHER *EVP_aria_192_cbc(void);
const EVP_CIPHER *EVP_aria_192_cfb1(void);
const EVP_CIPHER *EVP_aria_192_cfb8(void);
const EVP_CIPHER *EVP_aria_192_cfb128(void);
enum {
	EVP_aria_192_cfb     = EVP_aria_192_cfb128,
};
const EVP_CIPHER *EVP_aria_192_ctr(void);
const EVP_CIPHER *EVP_aria_192_ofb(void);
const EVP_CIPHER *EVP_aria_192_gcm(void);
const EVP_CIPHER *EVP_aria_192_ccm(void);
const EVP_CIPHER *EVP_aria_256_ecb(void);
const EVP_CIPHER *EVP_aria_256_cbc(void);
const EVP_CIPHER *EVP_aria_256_cfb1(void);
const EVP_CIPHER *EVP_aria_256_cfb8(void);
const EVP_CIPHER *EVP_aria_256_cfb128(void);
enum {
	EVP_aria_256_cfb     = EVP_aria_256_cfb128,
};
const EVP_CIPHER *EVP_aria_256_ctr(void);
const EVP_CIPHER *EVP_aria_256_ofb(void);
const EVP_CIPHER *EVP_aria_256_gcm(void);
const EVP_CIPHER *EVP_aria_256_ccm(void);
const EVP_CIPHER *EVP_camellia_128_ecb(void);
const EVP_CIPHER *EVP_camellia_128_cbc(void);
const EVP_CIPHER *EVP_camellia_128_cfb1(void);
const EVP_CIPHER *EVP_camellia_128_cfb8(void);
const EVP_CIPHER *EVP_camellia_128_cfb128(void);
enum {
	EVP_camellia_128_cfb = EVP_camellia_128_cfb128,
};
const EVP_CIPHER *EVP_camellia_128_ofb(void);
const EVP_CIPHER *EVP_camellia_128_ctr(void);
const EVP_CIPHER *EVP_camellia_192_ecb(void);
const EVP_CIPHER *EVP_camellia_192_cbc(void);
const EVP_CIPHER *EVP_camellia_192_cfb1(void);
const EVP_CIPHER *EVP_camellia_192_cfb8(void);
const EVP_CIPHER *EVP_camellia_192_cfb128(void);
enum {
	EVP_camellia_192_cfb = EVP_camellia_192_cfb128,
};
const EVP_CIPHER *EVP_camellia_192_ofb(void);
const EVP_CIPHER *EVP_camellia_192_ctr(void);
const EVP_CIPHER *EVP_camellia_256_ecb(void);
const EVP_CIPHER *EVP_camellia_256_cbc(void);
const EVP_CIPHER *EVP_camellia_256_cfb1(void);
const EVP_CIPHER *EVP_camellia_256_cfb8(void);
const EVP_CIPHER *EVP_camellia_256_cfb128(void);
enum {
	EVP_camellia_256_cfb = EVP_camellia_256_cfb128,
};
const EVP_CIPHER *EVP_camellia_256_ofb(void);
const EVP_CIPHER *EVP_camellia_256_ctr(void);
const EVP_CIPHER *EVP_chacha20(void);
const EVP_CIPHER *EVP_chacha20_poly1305(void);
const EVP_CIPHER *EVP_seed_ecb(void);
const EVP_CIPHER *EVP_seed_cbc(void);
const EVP_CIPHER *EVP_seed_cfb128(void);
enum {
	EVP_seed_cfb         = EVP_seed_cfb128,
};
const EVP_CIPHER *EVP_seed_ofb(void);
const EVP_CIPHER *EVP_sm4_ecb(void);
const EVP_CIPHER *EVP_sm4_cbc(void);
const EVP_CIPHER *EVP_sm4_cfb128(void);
enum {
	EVP_sm4_cfb          = EVP_sm4_cfb128,
};
const EVP_CIPHER *EVP_sm4_ofb(void);
const EVP_CIPHER *EVP_sm4_ctr(void);
#define OPENSSL_add_all_algorithms_conf() OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS | OPENSSL_INIT_LOAD_CONFIG, NULL)
#define OPENSSL_add_all_algorithms_noconf() OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS, NULL)
#define OpenSSL_add_all_algorithms() OPENSSL_add_all_algorithms_noconf()
#define OpenSSL_add_all_ciphers() OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS, NULL)
#define OpenSSL_add_all_digests() OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_DIGESTS, NULL)
#define EVP_cleanup() while(0) continue
int EVP_add_cipher(const EVP_CIPHER *cipher);
int EVP_add_digest(const EVP_MD *digest);
const EVP_CIPHER *EVP_get_cipherbyname(const char *name);
const EVP_MD *EVP_get_digestbyname(const char *name);
void EVP_CIPHER_do_all(void (*fn) (const EVP_CIPHER *ciph,
                                   const char *from, const char *to, void *x),
                       void *arg);
void EVP_CIPHER_do_all_sorted(void (*fn)
                               (const EVP_CIPHER *ciph, const char *from,
                                const char *to, void *x), void *arg);
void EVP_MD_do_all(void (*fn) (const EVP_MD *ciph,
                               const char *from, const char *to, void *x),
                   void *arg);
void EVP_MD_do_all_sorted(void (*fn)
                           (const EVP_MD *ciph, const char *from,
                            const char *to, void *x), void *arg);
int EVP_PKEY_decrypt_old(unsigned char *dec_key,
                         const unsigned char *enc_key, int enc_key_len,
                         EVP_PKEY *private_key);
int EVP_PKEY_encrypt_old(unsigned char *enc_key,
                         const unsigned char *key, int key_len,
                         EVP_PKEY *pub_key);
int EVP_PKEY_type(int type);
int EVP_PKEY_id(const EVP_PKEY *pkey);
int EVP_PKEY_base_id(const EVP_PKEY *pkey);
int EVP_PKEY_bits(const EVP_PKEY *pkey);
int EVP_PKEY_security_bits(const EVP_PKEY *pkey);
int EVP_PKEY_size(const EVP_PKEY *pkey);
int EVP_PKEY_set_type(EVP_PKEY *pkey, int type);
int EVP_PKEY_set_type_str(EVP_PKEY *pkey, const char *str, int len);
int EVP_PKEY_set_alias_type(EVP_PKEY *pkey, int type);
int EVP_PKEY_set1_engine(EVP_PKEY *pkey, ENGINE *e);
ENGINE *EVP_PKEY_get0_engine(const EVP_PKEY *pkey);
int EVP_PKEY_assign(EVP_PKEY *pkey, int type, void *key);
void *EVP_PKEY_get0(const EVP_PKEY *pkey);
const unsigned char *EVP_PKEY_get0_hmac(const EVP_PKEY *pkey, size_t *len);
const unsigned char *EVP_PKEY_get0_poly1305(const EVP_PKEY *pkey, size_t *len);
const unsigned char *EVP_PKEY_get0_siphash(const EVP_PKEY *pkey, size_t *len);
struct rsa_st;
int EVP_PKEY_set1_RSA(EVP_PKEY *pkey, struct rsa_st *key);
struct rsa_st *EVP_PKEY_get0_RSA(EVP_PKEY *pkey);
struct rsa_st *EVP_PKEY_get1_RSA(EVP_PKEY *pkey);
struct dsa_st;
int EVP_PKEY_set1_DSA(EVP_PKEY *pkey, struct dsa_st *key);
struct dsa_st *EVP_PKEY_get0_DSA(EVP_PKEY *pkey);
struct dsa_st *EVP_PKEY_get1_DSA(EVP_PKEY *pkey);
struct dh_st;
int EVP_PKEY_set1_DH(EVP_PKEY *pkey, struct dh_st *key);
struct dh_st *EVP_PKEY_get0_DH(EVP_PKEY *pkey);
struct dh_st *EVP_PKEY_get1_DH(EVP_PKEY *pkey);
struct ec_key_st;
int EVP_PKEY_set1_EC_KEY(EVP_PKEY *pkey, struct ec_key_st *key);
struct ec_key_st *EVP_PKEY_get0_EC_KEY(EVP_PKEY *pkey);
struct ec_key_st *EVP_PKEY_get1_EC_KEY(EVP_PKEY *pkey);
EVP_PKEY *EVP_PKEY_new(void);
int EVP_PKEY_up_ref(EVP_PKEY *pkey);
void EVP_PKEY_free(EVP_PKEY *pkey);
EVP_PKEY *d2i_PublicKey(int type, EVP_PKEY **a, const unsigned char **pp,
                        long length);
int i2d_PublicKey(EVP_PKEY *a, unsigned char **pp);
EVP_PKEY *d2i_PrivateKey(int type, EVP_PKEY **a, const unsigned char **pp,
                         long length);
EVP_PKEY *d2i_AutoPrivateKey(EVP_PKEY **a, const unsigned char **pp,
                             long length);
int i2d_PrivateKey(EVP_PKEY *a, unsigned char **pp);
int EVP_PKEY_copy_parameters(EVP_PKEY *to, const EVP_PKEY *from);
int EVP_PKEY_missing_parameters(const EVP_PKEY *pkey);
int EVP_PKEY_save_parameters(EVP_PKEY *pkey, int mode);
int EVP_PKEY_cmp_parameters(const EVP_PKEY *a, const EVP_PKEY *b);
int EVP_PKEY_cmp(const EVP_PKEY *a, const EVP_PKEY *b);
int EVP_PKEY_print_public(BIO *out, const EVP_PKEY *pkey,
                          int indent, ASN1_PCTX *pctx);
int EVP_PKEY_print_private(BIO *out, const EVP_PKEY *pkey,
                           int indent, ASN1_PCTX *pctx);
int EVP_PKEY_print_params(BIO *out, const EVP_PKEY *pkey,
                          int indent, ASN1_PCTX *pctx);
int EVP_PKEY_get_default_digest_nid(EVP_PKEY *pkey, int *pnid);
int EVP_PKEY_set1_tls_encodedpoint(EVP_PKEY *pkey,
                                   const unsigned char *pt, size_t ptlen);
size_t EVP_PKEY_get1_tls_encodedpoint(EVP_PKEY *pkey, unsigned char **ppt);
int EVP_CIPHER_type(const EVP_CIPHER *ctx);
int EVP_CIPHER_param_to_asn1(EVP_CIPHER_CTX *c, ASN1_TYPE *type);
int EVP_CIPHER_asn1_to_param(EVP_CIPHER_CTX *c, ASN1_TYPE *type);
int EVP_CIPHER_set_asn1_iv(EVP_CIPHER_CTX *c, ASN1_TYPE *type);
int EVP_CIPHER_get_asn1_iv(EVP_CIPHER_CTX *c, ASN1_TYPE *type);
int PKCS5_PBE_keyivgen(EVP_CIPHER_CTX *ctx, const char *pass, int passlen,
                       ASN1_TYPE *param, const EVP_CIPHER *cipher,
                       const EVP_MD *md, int en_de);
int PKCS5_PBKDF2_HMAC_SHA1(const char *pass, int passlen,
                           const unsigned char *salt, int saltlen, int iter,
                           int keylen, unsigned char *out);
int PKCS5_PBKDF2_HMAC(const char *pass, int passlen,
                      const unsigned char *salt, int saltlen, int iter,
                      const EVP_MD *digest, int keylen, unsigned char *out);
int PKCS5_v2_PBE_keyivgen(EVP_CIPHER_CTX *ctx, const char *pass, int passlen,
                          ASN1_TYPE *param, const EVP_CIPHER *cipher,
                          const EVP_MD *md, int en_de);
int EVP_PBE_scrypt(const char *pass, size_t passlen,
                   const unsigned char *salt, size_t saltlen,
                   uint64_t N, uint64_t r, uint64_t p, uint64_t maxmem,
                   unsigned char *key, size_t keylen);
int PKCS5_v2_scrypt_keyivgen(EVP_CIPHER_CTX *ctx, const char *pass,
                             int passlen, ASN1_TYPE *param,
                             const EVP_CIPHER *c, const EVP_MD *md, int en_de);
void PKCS5_PBE_add(void);
int EVP_PBE_CipherInit(ASN1_OBJECT *pbe_obj, const char *pass, int passlen,
                       ASN1_TYPE *param, EVP_CIPHER_CTX *ctx, int en_de);
enum {
	EVP_PBE_TYPE_OUTER   = 0x0,
	EVP_PBE_TYPE_PRF     = 0x1,
	EVP_PBE_TYPE_KDF     = 0x2,
};
int EVP_PBE_alg_add_type(int pbe_type, int pbe_nid, int cipher_nid,
                         int md_nid, EVP_PBE_KEYGEN *keygen);
int EVP_PBE_alg_add(int nid, const EVP_CIPHER *cipher, const EVP_MD *md,
                    EVP_PBE_KEYGEN *keygen);
int EVP_PBE_find(int type, int pbe_nid, int *pcnid, int *pmnid,
                 EVP_PBE_KEYGEN **pkeygen);
void EVP_PBE_cleanup(void);
int EVP_PBE_get(int *ptype, int *ppbe_nid, size_t num);
enum {
	ASN1_PKEY_ALIAS      = 0x1,
	ASN1_PKEY_DYNAMIC    = 0x2,
	ASN1_PKEY_SIGPARAM_NULL = 0x4,
	ASN1_PKEY_CTRL_PKCS7_SIGN = 0x1,
	ASN1_PKEY_CTRL_PKCS7_ENCRYPT = 0x2,
	ASN1_PKEY_CTRL_DEFAULT_MD_NID = 0x3,
	ASN1_PKEY_CTRL_CMS_SIGN = 0x5,
	ASN1_PKEY_CTRL_CMS_ENVELOPE = 0x7,
	ASN1_PKEY_CTRL_CMS_RI_TYPE = 0x8,
	ASN1_PKEY_CTRL_SET1_TLS_ENCPT = 0x9,
	ASN1_PKEY_CTRL_GET1_TLS_ENCPT = 0xa,
};
int EVP_PKEY_asn1_get_count(void);
const EVP_PKEY_ASN1_METHOD *EVP_PKEY_asn1_get0(int idx);
const EVP_PKEY_ASN1_METHOD *EVP_PKEY_asn1_find(ENGINE **pe, int type);
const EVP_PKEY_ASN1_METHOD *EVP_PKEY_asn1_find_str(ENGINE **pe,
                                                   const char *str, int len);
int EVP_PKEY_asn1_add0(const EVP_PKEY_ASN1_METHOD *ameth);
int EVP_PKEY_asn1_add_alias(int to, int from);
int EVP_PKEY_asn1_get0_info(int *ppkey_id, int *pkey_base_id,
                            int *ppkey_flags, const char **pinfo,
                            const char **ppem_str,
                            const EVP_PKEY_ASN1_METHOD *ameth);
const EVP_PKEY_ASN1_METHOD *EVP_PKEY_get0_asn1(const EVP_PKEY *pkey);
EVP_PKEY_ASN1_METHOD *EVP_PKEY_asn1_new(int id, int flags,
                                        const char *pem_str,
                                        const char *info);
void EVP_PKEY_asn1_copy(EVP_PKEY_ASN1_METHOD *dst,
                        const EVP_PKEY_ASN1_METHOD *src);
void EVP_PKEY_asn1_free(EVP_PKEY_ASN1_METHOD *ameth);
void EVP_PKEY_asn1_set_public(EVP_PKEY_ASN1_METHOD *ameth,
                              int (*pub_decode) (EVP_PKEY *pk,
                                                 X509_PUBKEY *pub),
                              int (*pub_encode) (X509_PUBKEY *pub,
                                                 const EVP_PKEY *pk),
                              int (*pub_cmp) (const EVP_PKEY *a,
                                              const EVP_PKEY *b),
                              int (*pub_print) (BIO *out,
                                                const EVP_PKEY *pkey,
                                                int indent, ASN1_PCTX *pctx),
                              int (*pkey_size) (const EVP_PKEY *pk),
                              int (*pkey_bits) (const EVP_PKEY *pk));
void EVP_PKEY_asn1_set_private(EVP_PKEY_ASN1_METHOD *ameth,
                               int (*priv_decode) (EVP_PKEY *pk,
                                                   const PKCS8_PRIV_KEY_INFO
                                                   *p8inf),
                               int (*priv_encode) (PKCS8_PRIV_KEY_INFO *p8,
                                                   const EVP_PKEY *pk),
                               int (*priv_print) (BIO *out,
                                                  const EVP_PKEY *pkey,
                                                  int indent,
                                                  ASN1_PCTX *pctx));
void EVP_PKEY_asn1_set_param(EVP_PKEY_ASN1_METHOD *ameth,
                             int (*param_decode) (EVP_PKEY *pkey,
                                                  const unsigned char **pder,
                                                  int derlen),
                             int (*param_encode) (const EVP_PKEY *pkey,
                                                  unsigned char **pder),
                             int (*param_missing) (const EVP_PKEY *pk),
                             int (*param_copy) (EVP_PKEY *to,
                                                const EVP_PKEY *from),
                             int (*param_cmp) (const EVP_PKEY *a,
                                               const EVP_PKEY *b),
                             int (*param_print) (BIO *out,
                                                 const EVP_PKEY *pkey,
                                                 int indent,
                                                 ASN1_PCTX *pctx));
void EVP_PKEY_asn1_set_free(EVP_PKEY_ASN1_METHOD *ameth,
                            void (*pkey_free) (EVP_PKEY *pkey));
void EVP_PKEY_asn1_set_ctrl(EVP_PKEY_ASN1_METHOD *ameth,
                            int (*pkey_ctrl) (EVP_PKEY *pkey, int op,
                                              long arg1, void *arg2));
void EVP_PKEY_asn1_set_item(EVP_PKEY_ASN1_METHOD *ameth,
                            int (*item_verify) (EVP_MD_CTX *ctx,
                                                const ASN1_ITEM *it,
                                                void *asn,
                                                X509_ALGOR *a,
                                                ASN1_BIT_STRING *sig,
                                                EVP_PKEY *pkey),
                            int (*item_sign) (EVP_MD_CTX *ctx,
                                              const ASN1_ITEM *it,
                                              void *asn,
                                              X509_ALGOR *alg1,
                                              X509_ALGOR *alg2,
                                              ASN1_BIT_STRING *sig));
void EVP_PKEY_asn1_set_siginf(EVP_PKEY_ASN1_METHOD *ameth,
                              int (*siginf_set) (X509_SIG_INFO *siginf,
                                                 const X509_ALGOR *alg,
                                                 const ASN1_STRING *sig));
void EVP_PKEY_asn1_set_check(EVP_PKEY_ASN1_METHOD *ameth,
                             int (*pkey_check) (const EVP_PKEY *pk));
void EVP_PKEY_asn1_set_public_check(EVP_PKEY_ASN1_METHOD *ameth,
                                    int (*pkey_pub_check) (const EVP_PKEY *pk));
void EVP_PKEY_asn1_set_param_check(EVP_PKEY_ASN1_METHOD *ameth,
                                   int (*pkey_param_check) (const EVP_PKEY *pk));
void EVP_PKEY_asn1_set_set_priv_key(EVP_PKEY_ASN1_METHOD *ameth,
                                    int (*set_priv_key) (EVP_PKEY *pk,
                                                         const unsigned char
                                                            *priv,
                                                         size_t len));
void EVP_PKEY_asn1_set_set_pub_key(EVP_PKEY_ASN1_METHOD *ameth,
                                   int (*set_pub_key) (EVP_PKEY *pk,
                                                       const unsigned char *pub,
                                                       size_t len));
void EVP_PKEY_asn1_set_get_priv_key(EVP_PKEY_ASN1_METHOD *ameth,
                                    int (*get_priv_key) (const EVP_PKEY *pk,
                                                         unsigned char *priv,
                                                         size_t *len));
void EVP_PKEY_asn1_set_get_pub_key(EVP_PKEY_ASN1_METHOD *ameth,
                                   int (*get_pub_key) (const EVP_PKEY *pk,
                                                       unsigned char *pub,
                                                       size_t *len));
void EVP_PKEY_asn1_set_security_bits(EVP_PKEY_ASN1_METHOD *ameth,
                                     int (*pkey_security_bits) (const EVP_PKEY
                                                                *pk));
enum {
	EVP_PKEY_OP_UNDEFINED = 0,
	EVP_PKEY_OP_PARAMGEN = (1<<1),
	EVP_PKEY_OP_KEYGEN   = (1<<2),
	EVP_PKEY_OP_SIGN     = (1<<3),
	EVP_PKEY_OP_VERIFY   = (1<<4),
	EVP_PKEY_OP_VERIFYRECOVER = (1<<5),
	EVP_PKEY_OP_SIGNCTX  = (1<<6),
	EVP_PKEY_OP_VERIFYCTX = (1<<7),
	EVP_PKEY_OP_ENCRYPT  = (1<<8),
	EVP_PKEY_OP_DECRYPT  = (1<<9),
	EVP_PKEY_OP_DERIVE   = (1<<10),
	EVP_PKEY_OP_TYPE_SIG = (EVP_PKEY_OP_SIGN | EVP_PKEY_OP_VERIFY | EVP_PKEY_OP_VERIFYRECOVER | EVP_PKEY_OP_SIGNCTX | EVP_PKEY_OP_VERIFYCTX),
	EVP_PKEY_OP_TYPE_CRYPT = (EVP_PKEY_OP_ENCRYPT | EVP_PKEY_OP_DECRYPT),
	EVP_PKEY_OP_TYPE_NOGEN = (EVP_PKEY_OP_TYPE_SIG | EVP_PKEY_OP_TYPE_CRYPT | EVP_PKEY_OP_DERIVE),
	EVP_PKEY_OP_TYPE_GEN = (EVP_PKEY_OP_PARAMGEN | EVP_PKEY_OP_KEYGEN),
};
#define EVP_PKEY_CTX_set_signature_md(ctx,md) EVP_PKEY_CTX_ctrl(ctx, -1, EVP_PKEY_OP_TYPE_SIG, EVP_PKEY_CTRL_MD, 0, (void *)(md))
#define EVP_PKEY_CTX_get_signature_md(ctx,pmd) EVP_PKEY_CTX_ctrl(ctx, -1, EVP_PKEY_OP_TYPE_SIG, EVP_PKEY_CTRL_GET_MD, 0, (void *)(pmd))
#define EVP_PKEY_CTX_set_mac_key(ctx,key,len) EVP_PKEY_CTX_ctrl(ctx, -1, EVP_PKEY_OP_KEYGEN, EVP_PKEY_CTRL_SET_MAC_KEY, len, (void *)(key))
enum {
	EVP_PKEY_CTRL_MD     = 1,
	EVP_PKEY_CTRL_PEER_KEY = 2,
	EVP_PKEY_CTRL_PKCS7_ENCRYPT = 3,
	EVP_PKEY_CTRL_PKCS7_DECRYPT = 4,
	EVP_PKEY_CTRL_PKCS7_SIGN = 5,
	EVP_PKEY_CTRL_SET_MAC_KEY = 6,
	EVP_PKEY_CTRL_DIGESTINIT = 7,
	EVP_PKEY_CTRL_SET_IV = 8,
	EVP_PKEY_CTRL_CMS_ENCRYPT = 9,
	EVP_PKEY_CTRL_CMS_DECRYPT = 10,
	EVP_PKEY_CTRL_CMS_SIGN = 11,
	EVP_PKEY_CTRL_CIPHER = 12,
	EVP_PKEY_CTRL_GET_MD = 13,
	EVP_PKEY_CTRL_SET_DIGEST_SIZE = 14,
	EVP_PKEY_ALG_CTRL    = 0x1000,
	EVP_PKEY_FLAG_AUTOARGLEN = 2,
	EVP_PKEY_FLAG_SIGCTX_CUSTOM = 4,
};
const EVP_PKEY_METHOD *EVP_PKEY_meth_find(int type);
EVP_PKEY_METHOD *EVP_PKEY_meth_new(int id, int flags);
void EVP_PKEY_meth_get0_info(int *ppkey_id, int *pflags,
                             const EVP_PKEY_METHOD *meth);
void EVP_PKEY_meth_copy(EVP_PKEY_METHOD *dst, const EVP_PKEY_METHOD *src);
void EVP_PKEY_meth_free(EVP_PKEY_METHOD *pmeth);
int EVP_PKEY_meth_add0(const EVP_PKEY_METHOD *pmeth);
int EVP_PKEY_meth_remove(const EVP_PKEY_METHOD *pmeth);
size_t EVP_PKEY_meth_get_count(void);
const EVP_PKEY_METHOD *EVP_PKEY_meth_get0(size_t idx);
EVP_PKEY_CTX *EVP_PKEY_CTX_new(EVP_PKEY *pkey, ENGINE *e);
EVP_PKEY_CTX *EVP_PKEY_CTX_new_id(int id, ENGINE *e);
EVP_PKEY_CTX *EVP_PKEY_CTX_dup(EVP_PKEY_CTX *ctx);
void EVP_PKEY_CTX_free(EVP_PKEY_CTX *ctx);
int EVP_PKEY_CTX_ctrl(EVP_PKEY_CTX *ctx, int keytype, int optype,
                      int cmd, int p1, void *p2);
int EVP_PKEY_CTX_ctrl_str(EVP_PKEY_CTX *ctx, const char *type,
                          const char *value);
int EVP_PKEY_CTX_ctrl_uint64(EVP_PKEY_CTX *ctx, int keytype, int optype,
                             int cmd, uint64_t value);
int EVP_PKEY_CTX_str2ctrl(EVP_PKEY_CTX *ctx, int cmd, const char *str);
int EVP_PKEY_CTX_hex2ctrl(EVP_PKEY_CTX *ctx, int cmd, const char *hex);
int EVP_PKEY_CTX_md(EVP_PKEY_CTX *ctx, int optype, int cmd, const char *md);
int EVP_PKEY_CTX_get_operation(EVP_PKEY_CTX *ctx);
void EVP_PKEY_CTX_set0_keygen_info(EVP_PKEY_CTX *ctx, int *dat, int datlen);
EVP_PKEY *EVP_PKEY_new_mac_key(int type, ENGINE *e,
                               const unsigned char *key, int keylen);
EVP_PKEY *EVP_PKEY_new_raw_private_key(int type, ENGINE *e,
                                       const unsigned char *priv,
                                       size_t len);
EVP_PKEY *EVP_PKEY_new_raw_public_key(int type, ENGINE *e,
                                      const unsigned char *pub,
                                      size_t len);
int EVP_PKEY_get_raw_private_key(const EVP_PKEY *pkey, unsigned char *priv,
                                 size_t *len);
int EVP_PKEY_get_raw_public_key(const EVP_PKEY *pkey, unsigned char *pub,
                                size_t *len);
EVP_PKEY *EVP_PKEY_new_CMAC_key(ENGINE *e, const unsigned char *priv,
                                size_t len, const EVP_CIPHER *cipher);
void EVP_PKEY_CTX_set_data(EVP_PKEY_CTX *ctx, void *data);
void *EVP_PKEY_CTX_get_data(EVP_PKEY_CTX *ctx);
EVP_PKEY *EVP_PKEY_CTX_get0_pkey(EVP_PKEY_CTX *ctx);
EVP_PKEY *EVP_PKEY_CTX_get0_peerkey(EVP_PKEY_CTX *ctx);
void EVP_PKEY_CTX_set_app_data(EVP_PKEY_CTX *ctx, void *data);
void *EVP_PKEY_CTX_get_app_data(EVP_PKEY_CTX *ctx);
int EVP_PKEY_sign_init(EVP_PKEY_CTX *ctx);
int EVP_PKEY_sign(EVP_PKEY_CTX *ctx,
                  unsigned char *sig, size_t *siglen,
                  const unsigned char *tbs, size_t tbslen);
int EVP_PKEY_verify_init(EVP_PKEY_CTX *ctx);
int EVP_PKEY_verify(EVP_PKEY_CTX *ctx,
                    const unsigned char *sig, size_t siglen,
                    const unsigned char *tbs, size_t tbslen);
int EVP_PKEY_verify_recover_init(EVP_PKEY_CTX *ctx);
int EVP_PKEY_verify_recover(EVP_PKEY_CTX *ctx,
                            unsigned char *rout, size_t *routlen,
                            const unsigned char *sig, size_t siglen);
int EVP_PKEY_encrypt_init(EVP_PKEY_CTX *ctx);
int EVP_PKEY_encrypt(EVP_PKEY_CTX *ctx,
                     unsigned char *out, size_t *outlen,
                     const unsigned char *in, size_t inlen);
int EVP_PKEY_decrypt_init(EVP_PKEY_CTX *ctx);
int EVP_PKEY_decrypt(EVP_PKEY_CTX *ctx,
                     unsigned char *out, size_t *outlen,
                     const unsigned char *in, size_t inlen);
int EVP_PKEY_derive_init(EVP_PKEY_CTX *ctx);
int EVP_PKEY_derive_set_peer(EVP_PKEY_CTX *ctx, EVP_PKEY *peer);
int EVP_PKEY_derive(EVP_PKEY_CTX *ctx, unsigned char *key, size_t *keylen);
typedef int EVP_PKEY_gen_cb(EVP_PKEY_CTX *ctx);
int EVP_PKEY_paramgen_init(EVP_PKEY_CTX *ctx);
int EVP_PKEY_paramgen(EVP_PKEY_CTX *ctx, EVP_PKEY **ppkey);
int EVP_PKEY_keygen_init(EVP_PKEY_CTX *ctx);
int EVP_PKEY_keygen(EVP_PKEY_CTX *ctx, EVP_PKEY **ppkey);
int EVP_PKEY_check(EVP_PKEY_CTX *ctx);
int EVP_PKEY_public_check(EVP_PKEY_CTX *ctx);
int EVP_PKEY_param_check(EVP_PKEY_CTX *ctx);
void EVP_PKEY_CTX_set_cb(EVP_PKEY_CTX *ctx, EVP_PKEY_gen_cb *cb);
EVP_PKEY_gen_cb *EVP_PKEY_CTX_get_cb(EVP_PKEY_CTX *ctx);
int EVP_PKEY_CTX_get_keygen_info(EVP_PKEY_CTX *ctx, int idx);
void EVP_PKEY_meth_set_init(EVP_PKEY_METHOD *pmeth,
                            int (*init) (EVP_PKEY_CTX *ctx));
void EVP_PKEY_meth_set_copy(EVP_PKEY_METHOD *pmeth,
                            int (*copy) (EVP_PKEY_CTX *dst,
                                         EVP_PKEY_CTX *src));
void EVP_PKEY_meth_set_cleanup(EVP_PKEY_METHOD *pmeth,
                               void (*cleanup) (EVP_PKEY_CTX *ctx));
void EVP_PKEY_meth_set_paramgen(EVP_PKEY_METHOD *pmeth,
                                int (*paramgen_init) (EVP_PKEY_CTX *ctx),
                                int (*paramgen) (EVP_PKEY_CTX *ctx,
                                                 EVP_PKEY *pkey));
void EVP_PKEY_meth_set_keygen(EVP_PKEY_METHOD *pmeth,
                              int (*keygen_init) (EVP_PKEY_CTX *ctx),
                              int (*keygen) (EVP_PKEY_CTX *ctx,
                                             EVP_PKEY *pkey));
void EVP_PKEY_meth_set_sign(EVP_PKEY_METHOD *pmeth,
                            int (*sign_init) (EVP_PKEY_CTX *ctx),
                            int (*sign) (EVP_PKEY_CTX *ctx,
                                         unsigned char *sig, size_t *siglen,
                                         const unsigned char *tbs,
                                         size_t tbslen));
void EVP_PKEY_meth_set_verify(EVP_PKEY_METHOD *pmeth,
                              int (*verify_init) (EVP_PKEY_CTX *ctx),
                              int (*verify) (EVP_PKEY_CTX *ctx,
                                             const unsigned char *sig,
                                             size_t siglen,
                                             const unsigned char *tbs,
                                             size_t tbslen));
void EVP_PKEY_meth_set_verify_recover(EVP_PKEY_METHOD *pmeth,
                                      int (*verify_recover_init) (EVP_PKEY_CTX
                                                                  *ctx),
                                      int (*verify_recover) (EVP_PKEY_CTX
                                                             *ctx,
                                                             unsigned char
                                                             *sig,
                                                             size_t *siglen,
                                                             const unsigned
                                                             char *tbs,
                                                             size_t tbslen));
void EVP_PKEY_meth_set_signctx(EVP_PKEY_METHOD *pmeth,
                               int (*signctx_init) (EVP_PKEY_CTX *ctx,
                                                    EVP_MD_CTX *mctx),
                               int (*signctx) (EVP_PKEY_CTX *ctx,
                                               unsigned char *sig,
                                               size_t *siglen,
                                               EVP_MD_CTX *mctx));
void EVP_PKEY_meth_set_verifyctx(EVP_PKEY_METHOD *pmeth,
                                 int (*verifyctx_init) (EVP_PKEY_CTX *ctx,
                                                        EVP_MD_CTX *mctx),
                                 int (*verifyctx) (EVP_PKEY_CTX *ctx,
                                                   const unsigned char *sig,
                                                   int siglen,
                                                   EVP_MD_CTX *mctx));
void EVP_PKEY_meth_set_encrypt(EVP_PKEY_METHOD *pmeth,
                               int (*encrypt_init) (EVP_PKEY_CTX *ctx),
                               int (*encryptfn) (EVP_PKEY_CTX *ctx,
                                                 unsigned char *out,
                                                 size_t *outlen,
                                                 const unsigned char *in,
                                                 size_t inlen));
void EVP_PKEY_meth_set_decrypt(EVP_PKEY_METHOD *pmeth,
                               int (*decrypt_init) (EVP_PKEY_CTX *ctx),
                               int (*decrypt) (EVP_PKEY_CTX *ctx,
                                               unsigned char *out,
                                               size_t *outlen,
                                               const unsigned char *in,
                                               size_t inlen));
void EVP_PKEY_meth_set_derive(EVP_PKEY_METHOD *pmeth,
                              int (*derive_init) (EVP_PKEY_CTX *ctx),
                              int (*derive) (EVP_PKEY_CTX *ctx,
                                             unsigned char *key,
                                             size_t *keylen));
void EVP_PKEY_meth_set_ctrl(EVP_PKEY_METHOD *pmeth,
                            int (*ctrl) (EVP_PKEY_CTX *ctx, int type, int p1,
                                         void *p2),
                            int (*ctrl_str) (EVP_PKEY_CTX *ctx,
                                             const char *type,
                                             const char *value));
void EVP_PKEY_meth_set_check(EVP_PKEY_METHOD *pmeth,
                             int (*check) (EVP_PKEY *pkey));
void EVP_PKEY_meth_set_public_check(EVP_PKEY_METHOD *pmeth,
                                    int (*check) (EVP_PKEY *pkey));
void EVP_PKEY_meth_set_param_check(EVP_PKEY_METHOD *pmeth,
                                   int (*check) (EVP_PKEY *pkey));
void EVP_PKEY_meth_set_digest_custom(EVP_PKEY_METHOD *pmeth,
                                     int (*digest_custom) (EVP_PKEY_CTX *ctx,
                                                           EVP_MD_CTX *mctx));
void EVP_PKEY_meth_get_init(const EVP_PKEY_METHOD *pmeth,
                            int (**pinit) (EVP_PKEY_CTX *ctx));
void EVP_PKEY_meth_get_copy(const EVP_PKEY_METHOD *pmeth,
                            int (**pcopy) (EVP_PKEY_CTX *dst,
                                           EVP_PKEY_CTX *src));
void EVP_PKEY_meth_get_cleanup(const EVP_PKEY_METHOD *pmeth,
                               void (**pcleanup) (EVP_PKEY_CTX *ctx));
void EVP_PKEY_meth_get_paramgen(const EVP_PKEY_METHOD *pmeth,
                                int (**pparamgen_init) (EVP_PKEY_CTX *ctx),
                                int (**pparamgen) (EVP_PKEY_CTX *ctx,
                                                   EVP_PKEY *pkey));
void EVP_PKEY_meth_get_keygen(const EVP_PKEY_METHOD *pmeth,
                              int (**pkeygen_init) (EVP_PKEY_CTX *ctx),
                              int (**pkeygen) (EVP_PKEY_CTX *ctx,
                                               EVP_PKEY *pkey));
void EVP_PKEY_meth_get_sign(const EVP_PKEY_METHOD *pmeth,
                            int (**psign_init) (EVP_PKEY_CTX *ctx),
                            int (**psign) (EVP_PKEY_CTX *ctx,
                                           unsigned char *sig, size_t *siglen,
                                           const unsigned char *tbs,
                                           size_t tbslen));
void EVP_PKEY_meth_get_verify(const EVP_PKEY_METHOD *pmeth,
                              int (**pverify_init) (EVP_PKEY_CTX *ctx),
                              int (**pverify) (EVP_PKEY_CTX *ctx,
                                               const unsigned char *sig,
                                               size_t siglen,
                                               const unsigned char *tbs,
                                               size_t tbslen));
void EVP_PKEY_meth_get_verify_recover(const EVP_PKEY_METHOD *pmeth,
                                      int (**pverify_recover_init) (EVP_PKEY_CTX
                                                                    *ctx),
                                      int (**pverify_recover) (EVP_PKEY_CTX
                                                               *ctx,
                                                               unsigned char
                                                               *sig,
                                                               size_t *siglen,
                                                               const unsigned
                                                               char *tbs,
                                                               size_t tbslen));
void EVP_PKEY_meth_get_signctx(const EVP_PKEY_METHOD *pmeth,
                               int (**psignctx_init) (EVP_PKEY_CTX *ctx,
                                                      EVP_MD_CTX *mctx),
                               int (**psignctx) (EVP_PKEY_CTX *ctx,
                                                 unsigned char *sig,
                                                 size_t *siglen,
                                                 EVP_MD_CTX *mctx));
void EVP_PKEY_meth_get_verifyctx(const EVP_PKEY_METHOD *pmeth,
                                 int (**pverifyctx_init) (EVP_PKEY_CTX *ctx,
                                                          EVP_MD_CTX *mctx),
                                 int (**pverifyctx) (EVP_PKEY_CTX *ctx,
                                                     const unsigned char *sig,
                                                     int siglen,
                                                     EVP_MD_CTX *mctx));
void EVP_PKEY_meth_get_encrypt(const EVP_PKEY_METHOD *pmeth,
                               int (**pencrypt_init) (EVP_PKEY_CTX *ctx),
                               int (**pencryptfn) (EVP_PKEY_CTX *ctx,
                                                   unsigned char *out,
                                                   size_t *outlen,
                                                   const unsigned char *in,
                                                   size_t inlen));
void EVP_PKEY_meth_get_decrypt(const EVP_PKEY_METHOD *pmeth,
                               int (**pdecrypt_init) (EVP_PKEY_CTX *ctx),
                               int (**pdecrypt) (EVP_PKEY_CTX *ctx,
                                                 unsigned char *out,
                                                 size_t *outlen,
                                                 const unsigned char *in,
                                                 size_t inlen));
void EVP_PKEY_meth_get_derive(const EVP_PKEY_METHOD *pmeth,
                              int (**pderive_init) (EVP_PKEY_CTX *ctx),
                              int (**pderive) (EVP_PKEY_CTX *ctx,
                                               unsigned char *key,
                                               size_t *keylen));
void EVP_PKEY_meth_get_ctrl(const EVP_PKEY_METHOD *pmeth,
                            int (**pctrl) (EVP_PKEY_CTX *ctx, int type, int p1,
                                           void *p2),
                            int (**pctrl_str) (EVP_PKEY_CTX *ctx,
                                               const char *type,
                                               const char *value));
void EVP_PKEY_meth_get_check(const EVP_PKEY_METHOD *pmeth,
                             int (**pcheck) (EVP_PKEY *pkey));
void EVP_PKEY_meth_get_public_check(const EVP_PKEY_METHOD *pmeth,
                                    int (**pcheck) (EVP_PKEY *pkey));
void EVP_PKEY_meth_get_param_check(const EVP_PKEY_METHOD *pmeth,
                                   int (**pcheck) (EVP_PKEY *pkey));
void EVP_PKEY_meth_get_digest_custom(EVP_PKEY_METHOD *pmeth,
                                     int (**pdigest_custom) (EVP_PKEY_CTX *ctx,
                                                             EVP_MD_CTX *mctx));
void EVP_add_alg_module(void);

// csrc/openssl/src/include/openssl/evperr.h
int ERR_load_EVP_strings(void);
enum {
	EVP_F_AESNI_INIT_KEY = 165,
	EVP_F_AESNI_XTS_INIT_KEY = 207,
	EVP_F_AES_GCM_CTRL   = 196,
	EVP_F_AES_INIT_KEY   = 133,
	EVP_F_AES_OCB_CIPHER = 169,
	EVP_F_AES_T4_INIT_KEY = 178,
	EVP_F_AES_T4_XTS_INIT_KEY = 208,
	EVP_F_AES_WRAP_CIPHER = 170,
	EVP_F_AES_XTS_INIT_KEY = 209,
	EVP_F_ALG_MODULE_INIT = 177,
	EVP_F_ARIA_CCM_INIT_KEY = 175,
	EVP_F_ARIA_GCM_CTRL  = 197,
	EVP_F_ARIA_GCM_INIT_KEY = 176,
	EVP_F_ARIA_INIT_KEY  = 185,
	EVP_F_B64_NEW        = 198,
	EVP_F_CAMELLIA_INIT_KEY = 159,
	EVP_F_CHACHA20_POLY1305_CTRL = 182,
	EVP_F_CMLL_T4_INIT_KEY = 179,
	EVP_F_DES_EDE3_WRAP_CIPHER = 171,
	EVP_F_DO_SIGVER_INIT = 161,
	EVP_F_ENC_NEW        = 199,
	EVP_F_EVP_CIPHERINIT_EX = 123,
	EVP_F_EVP_CIPHER_ASN1_TO_PARAM = 204,
	EVP_F_EVP_CIPHER_CTX_COPY = 163,
	EVP_F_EVP_CIPHER_CTX_CTRL = 124,
	EVP_F_EVP_CIPHER_CTX_SET_KEY_LENGTH = 122,
	EVP_F_EVP_CIPHER_PARAM_TO_ASN1 = 205,
	EVP_F_EVP_DECRYPTFINAL_EX = 101,
	EVP_F_EVP_DECRYPTUPDATE = 166,
	EVP_F_EVP_DIGESTFINALXOF = 174,
	EVP_F_EVP_DIGESTINIT_EX = 128,
	EVP_F_EVP_ENCRYPTDECRYPTUPDATE = 219,
	EVP_F_EVP_ENCRYPTFINAL_EX = 127,
	EVP_F_EVP_ENCRYPTUPDATE = 167,
	EVP_F_EVP_MD_CTX_COPY_EX = 110,
	EVP_F_EVP_MD_SIZE    = 162,
	EVP_F_EVP_OPENINIT   = 102,
	EVP_F_EVP_PBE_ALG_ADD = 115,
	EVP_F_EVP_PBE_ALG_ADD_TYPE = 160,
	EVP_F_EVP_PBE_CIPHERINIT = 116,
	EVP_F_EVP_PBE_SCRYPT = 181,
	EVP_F_EVP_PKCS82PKEY = 111,
	EVP_F_EVP_PKEY2PKCS8 = 113,
	EVP_F_EVP_PKEY_ASN1_ADD0 = 188,
	EVP_F_EVP_PKEY_CHECK = 186,
	EVP_F_EVP_PKEY_COPY_PARAMETERS = 103,
	EVP_F_EVP_PKEY_CTX_CTRL = 137,
	EVP_F_EVP_PKEY_CTX_CTRL_STR = 150,
	EVP_F_EVP_PKEY_CTX_DUP = 156,
	EVP_F_EVP_PKEY_CTX_MD = 168,
	EVP_F_EVP_PKEY_DECRYPT = 104,
	EVP_F_EVP_PKEY_DECRYPT_INIT = 138,
	EVP_F_EVP_PKEY_DECRYPT_OLD = 151,
	EVP_F_EVP_PKEY_DERIVE = 153,
	EVP_F_EVP_PKEY_DERIVE_INIT = 154,
	EVP_F_EVP_PKEY_DERIVE_SET_PEER = 155,
	EVP_F_EVP_PKEY_ENCRYPT = 105,
	EVP_F_EVP_PKEY_ENCRYPT_INIT = 139,
	EVP_F_EVP_PKEY_ENCRYPT_OLD = 152,
	EVP_F_EVP_PKEY_GET0_DH = 119,
	EVP_F_EVP_PKEY_GET0_DSA = 120,
	EVP_F_EVP_PKEY_GET0_EC_KEY = 131,
	EVP_F_EVP_PKEY_GET0_HMAC = 183,
	EVP_F_EVP_PKEY_GET0_POLY1305 = 184,
	EVP_F_EVP_PKEY_GET0_RSA = 121,
	EVP_F_EVP_PKEY_GET0_SIPHASH = 172,
	EVP_F_EVP_PKEY_GET_RAW_PRIVATE_KEY = 202,
	EVP_F_EVP_PKEY_GET_RAW_PUBLIC_KEY = 203,
	EVP_F_EVP_PKEY_KEYGEN = 146,
	EVP_F_EVP_PKEY_KEYGEN_INIT = 147,
	EVP_F_EVP_PKEY_METH_ADD0 = 194,
	EVP_F_EVP_PKEY_METH_NEW = 195,
	EVP_F_EVP_PKEY_NEW   = 106,
	EVP_F_EVP_PKEY_NEW_CMAC_KEY = 193,
	EVP_F_EVP_PKEY_NEW_RAW_PRIVATE_KEY = 191,
	EVP_F_EVP_PKEY_NEW_RAW_PUBLIC_KEY = 192,
	EVP_F_EVP_PKEY_PARAMGEN = 148,
	EVP_F_EVP_PKEY_PARAMGEN_INIT = 149,
	EVP_F_EVP_PKEY_PARAM_CHECK = 189,
	EVP_F_EVP_PKEY_PUBLIC_CHECK = 190,
	EVP_F_EVP_PKEY_SET1_ENGINE = 187,
	EVP_F_EVP_PKEY_SET_ALIAS_TYPE = 206,
	EVP_F_EVP_PKEY_SIGN  = 140,
	EVP_F_EVP_PKEY_SIGN_INIT = 141,
	EVP_F_EVP_PKEY_VERIFY = 142,
	EVP_F_EVP_PKEY_VERIFY_INIT = 143,
	EVP_F_EVP_PKEY_VERIFY_RECOVER = 144,
	EVP_F_EVP_PKEY_VERIFY_RECOVER_INIT = 145,
	EVP_F_EVP_SIGNFINAL  = 107,
	EVP_F_EVP_VERIFYFINAL = 108,
	EVP_F_INT_CTX_NEW    = 157,
	EVP_F_OK_NEW         = 200,
	EVP_F_PKCS5_PBE_KEYIVGEN = 117,
	EVP_F_PKCS5_V2_PBE_KEYIVGEN = 118,
	EVP_F_PKCS5_V2_PBKDF2_KEYIVGEN = 164,
	EVP_F_PKCS5_V2_SCRYPT_KEYIVGEN = 180,
	EVP_F_PKEY_SET_TYPE  = 158,
	EVP_F_RC2_MAGIC_TO_METH = 109,
	EVP_F_RC5_CTRL       = 125,
	EVP_F_R_32_12_16_INIT_KEY = 242,
	EVP_F_S390X_AES_GCM_CTRL = 201,
	EVP_F_UPDATE         = 173,
	EVP_R_AES_KEY_SETUP_FAILED = 143,
	EVP_R_ARIA_KEY_SETUP_FAILED = 176,
	EVP_R_BAD_DECRYPT    = 100,
	EVP_R_BAD_KEY_LENGTH = 195,
	EVP_R_BUFFER_TOO_SMALL = 155,
	EVP_R_CAMELLIA_KEY_SETUP_FAILED = 157,
	EVP_R_CIPHER_PARAMETER_ERROR = 122,
	EVP_R_COMMAND_NOT_SUPPORTED = 147,
	EVP_R_COPY_ERROR     = 173,
	EVP_R_CTRL_NOT_IMPLEMENTED = 132,
	EVP_R_CTRL_OPERATION_NOT_IMPLEMENTED = 133,
	EVP_R_DATA_NOT_MULTIPLE_OF_BLOCK_LENGTH = 138,
	EVP_R_DECODE_ERROR   = 114,
	EVP_R_DIFFERENT_KEY_TYPES = 101,
	EVP_R_DIFFERENT_PARAMETERS = 153,
	EVP_R_ERROR_LOADING_SECTION = 165,
	EVP_R_ERROR_SETTING_FIPS_MODE = 166,
	EVP_R_EXPECTING_AN_HMAC_KEY = 174,
	EVP_R_EXPECTING_AN_RSA_KEY = 127,
	EVP_R_EXPECTING_A_DH_KEY = 128,
	EVP_R_EXPECTING_A_DSA_KEY = 129,
	EVP_R_EXPECTING_A_EC_KEY = 142,
	EVP_R_EXPECTING_A_POLY1305_KEY = 164,
	EVP_R_EXPECTING_A_SIPHASH_KEY = 175,
	EVP_R_FIPS_MODE_NOT_SUPPORTED = 167,
	EVP_R_GET_RAW_KEY_FAILED = 182,
	EVP_R_ILLEGAL_SCRYPT_PARAMETERS = 171,
	EVP_R_INITIALIZATION_ERROR = 134,
	EVP_R_INPUT_NOT_INITIALIZED = 111,
	EVP_R_INVALID_DIGEST = 152,
	EVP_R_INVALID_FIPS_MODE = 168,
	EVP_R_INVALID_KEY    = 163,
	EVP_R_INVALID_KEY_LENGTH = 130,
	EVP_R_INVALID_OPERATION = 148,
	EVP_R_KEYGEN_FAILURE = 120,
	EVP_R_KEY_SETUP_FAILED = 180,
	EVP_R_MEMORY_LIMIT_EXCEEDED = 172,
	EVP_R_MESSAGE_DIGEST_IS_NULL = 159,
	EVP_R_METHOD_NOT_SUPPORTED = 144,
	EVP_R_MISSING_PARAMETERS = 103,
	EVP_R_NOT_XOF_OR_INVALID_LENGTH = 178,
	EVP_R_NO_CIPHER_SET  = 131,
	EVP_R_NO_DEFAULT_DIGEST = 158,
	EVP_R_NO_DIGEST_SET  = 139,
	EVP_R_NO_KEY_SET     = 154,
	EVP_R_NO_OPERATION_SET = 149,
	EVP_R_ONLY_ONESHOT_SUPPORTED = 177,
	EVP_R_OPERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE = 150,
	EVP_R_OPERATON_NOT_INITIALIZED = 151,
	EVP_R_PARTIALLY_OVERLAPPING = 162,
	EVP_R_PBKDF2_ERROR   = 181,
	EVP_R_PKEY_APPLICATION_ASN1_METHOD_ALREADY_REGISTERED = 179,
	EVP_R_PRIVATE_KEY_DECODE_ERROR = 145,
	EVP_R_PRIVATE_KEY_ENCODE_ERROR = 146,
	EVP_R_PUBLIC_KEY_NOT_RSA = 106,
	EVP_R_UNKNOWN_CIPHER = 160,
	EVP_R_UNKNOWN_DIGEST = 161,
	EVP_R_UNKNOWN_OPTION = 169,
	EVP_R_UNKNOWN_PBE_ALGORITHM = 121,
	EVP_R_UNSUPPORTED_ALGORITHM = 156,
	EVP_R_UNSUPPORTED_CIPHER = 107,
	EVP_R_UNSUPPORTED_KEYLENGTH = 123,
	EVP_R_UNSUPPORTED_KEY_DERIVATION_FUNCTION = 124,
	EVP_R_UNSUPPORTED_KEY_SIZE = 108,
	EVP_R_UNSUPPORTED_NUMBER_OF_ROUNDS = 135,
	EVP_R_UNSUPPORTED_PRF = 125,
	EVP_R_UNSUPPORTED_PRIVATE_KEY_ALGORITHM = 118,
	EVP_R_UNSUPPORTED_SALT_TYPE = 126,
	EVP_R_WRAP_MODE_NOT_ALLOWED = 170,
	EVP_R_WRONG_FINAL_BLOCK_LENGTH = 109,
	EVP_R_XTS_DUPLICATED_KEYS = 183,
};
]]
