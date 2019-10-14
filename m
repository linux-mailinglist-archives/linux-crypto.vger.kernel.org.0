Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3207CD5E7B
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Oct 2019 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfJNJRs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 14 Oct 2019 05:17:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730798AbfJNJRs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 14 Oct 2019 05:17:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDF18B978;
        Mon, 14 Oct 2019 09:17:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8CB5EDA7E3; Mon, 14 Oct 2019 11:16:51 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-crypto@vger.kernel.org
Cc:     ebiggers@google.com, ard.biesheuvel@linaro.org,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v5 2/2] crypto: add test vectors for blake2b
Date:   Mon, 14 Oct 2019 11:16:44 +0200
Message-Id: <a4e3e9db53b01c4092309a75e5b5d703ed344c5a.1571043883.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571043883.git.dsterba@suse.com>
References: <cover.1571043883.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Test vectors for blake2b with various digest sizes. As the algorithm is
the same up to the digest calculation, the key and input data length is
distributed in a way that tests all combinanions of the two over the
digest sizes.

Based on the suggestion from Eric, the following input sizes are tested
[0, 1, 7, 15, 64, 247, 256], where blake2b blocksize is 128, so the
padded and the non-padded input buffers are tested.

          blake2b-160  blake2b-256  blake2b-384  blake2b-512
         ---------------------------------------------------
len=0   | klen=0       klen=1       klen=32      klen=64
len=1   | klen=32      klen=64      klen=0       klen=1
len=7   | klen=64      klen=0       klen=1       klen=32
len=15  | klen=1       klen=32      klen=64      klen=0
len=64  | klen=0       klen=1       klen=32      klen=64
len=247 | klen=32      klen=64      klen=0       klen=1
len=256 | klen=64      klen=0       klen=1       klen=32

Where key:

- klen=0: empty key
- klen=1: 1 byte value 0x42, 'B'
- klen=32: first 32 bytes of the default key, sequence 00..1f
- klen=64: default key, sequence 00..3f

The unkeyed vectors are ordered before keyed, as this is required by
testmgr.

CC: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 crypto/testmgr.c |  28 ++
 crypto/testmgr.h | 719 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 747 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index c39e39e55dc2..0f956780a673 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4022,6 +4022,34 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "authenc(hmac(sha512),rfc3686(ctr(aes)))",
 		.test = alg_test_null,
 		.fips_allowed = 1,
+	}, {
+		.alg = "blake2b-160",
+		.test = alg_test_hash,
+		.fips_allowed = 0,
+		.suite = {
+			.hash = __VECS(blake2b_160_tv_template)
+		}
+	}, {
+		.alg = "blake2b-256",
+		.test = alg_test_hash,
+		.fips_allowed = 0,
+		.suite = {
+			.hash = __VECS(blake2b_256_tv_template)
+		}
+	}, {
+		.alg = "blake2b-384",
+		.test = alg_test_hash,
+		.fips_allowed = 0,
+		.suite = {
+			.hash = __VECS(blake2b_384_tv_template)
+		}
+	}, {
+		.alg = "blake2b-512",
+		.test = alg_test_hash,
+		.fips_allowed = 0,
+		.suite = {
+			.hash = __VECS(blake2b_512_tv_template)
+		}
 	}, {
 		.alg = "cbc(aes)",
 		.test = alg_test_skcipher,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index ef7d21f39d4a..e6a4806f0ccd 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -31567,4 +31567,723 @@ static const struct aead_testvec essiv_hmac_sha256_aes_cbc_tv_temp[] = {
 	},
 };
 
+static const struct hash_testvec blake2b_160_tv_template[] = {
+	{
+		.plaintext =
+			"",
+		.psize     = 0,
+		.digest    =
+			"\x33\x45\x52\x4a\xbf\x6b\xbe\x18"
+			"\x09\x44\x92\x24\xb5\x97\x2c\x41"
+			"\x79\x0b\x6c\xf2",
+	}, {
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.psize     = 64,
+		.digest    =
+			"\x11\xcc\x66\x61\xe9\x22\xb0\xe4"
+			"\x07\xe0\xa5\x72\x49\xc3\x8d\x4f"
+			"\xf7\x6d\x8e\xc8",
+	}, {
+		.ksize     = 32,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f",
+		.plaintext =
+			"\x00",
+		.psize     = 1,
+		.digest    =
+			"\x31\xe3\xd9\xd5\x4e\x72\xd8\x0b"
+			"\x2b\x3b\xd7\x6b\x82\x7a\x1d\xfb"
+			"\x56\x2f\x79\x4c",
+	}, {
+		.ksize     = 64,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06",
+		.psize     = 7,
+		.digest    =
+			"\x28\x20\xd1\xbe\x7f\xcc\xc1\x62"
+			"\xd9\x0d\x9a\x4b\x47\xd1\x5e\x04"
+			"\x74\x2a\x53\x17",
+	}, {
+		.ksize     = 1,
+		.key       =
+			"\x42",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e",
+		.psize     = 15,
+		.digest    =
+			"\x45\xe9\x95\xb6\xc4\xe8\x22\xea"
+			"\xfe\xd2\x37\xdb\x46\xbf\xf1\x25"
+			"\xd5\x03\x1d\x81",
+	}, {
+		.ksize     = 32,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47"
+			"\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
+			"\x50\x51\x52\x53\x54\x55\x56\x57"
+			"\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
+			"\x60\x61\x62\x63\x64\x65\x66\x67"
+			"\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77"
+			"\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87"
+			"\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97"
+			"\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7"
+			"\xa8\xa9\xaa\xab\xac\xad\xae\xaf"
+			"\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7"
+			"\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7"
+			"\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7"
+			"\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7"
+			"\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6",
+		.psize     = 247,
+		.digest    =
+			"\x7e\xb9\xf2\x9b\x2f\xc2\x01\xd4"
+			"\xb0\x4f\x08\x2b\x8e\xbd\x06\xef"
+			"\x1c\xc4\x25\x95",
+	}, {
+		.ksize     = 64,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47"
+			"\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
+			"\x50\x51\x52\x53\x54\x55\x56\x57"
+			"\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
+			"\x60\x61\x62\x63\x64\x65\x66\x67"
+			"\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77"
+			"\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87"
+			"\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97"
+			"\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7"
+			"\xa8\xa9\xaa\xab\xac\xad\xae\xaf"
+			"\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7"
+			"\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7"
+			"\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7"
+			"\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7"
+			"\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7"
+			"\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff",
+		.psize     = 256,
+		.digest    =
+			"\x6e\x35\x01\x70\xbf\xb6\xc4\xba"
+			"\x33\x1b\xa6\xd3\xc2\x5d\xb4\x03"
+			"\x95\xaf\x29\x16",
+	}
+};
+
+static const struct hash_testvec blake2b_256_tv_template[] = {
+	{
+		.plaintext =
+			"",
+		.psize     = 0,
+		.digest    =
+			"\x0e\x57\x51\xc0\x26\xe5\x43\xb2"
+			"\xe8\xab\x2e\xb0\x60\x99\xda\xa1"
+			"\xd1\xe5\xdf\x47\x77\x8f\x77\x87"
+			"\xfa\xab\x45\xcd\xf1\x2f\xe3\xa8",
+	}, {
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.psize     = 64,
+		.digest    =
+			"\x10\xd8\xe6\xd5\x34\xb0\x09\x39"
+			"\x84\x3f\xe9\xdc\xc4\xda\xe4\x8c"
+			"\xdf\x00\x8f\x6b\x8b\x2b\x82\xb1"
+			"\x56\xf5\x40\x4d\x87\x48\x87\xf5",
+	}, {
+		.ksize     = 32,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f",
+		.plaintext =
+			"\x00",
+		.psize     = 1,
+		.digest    =
+			"\x41\xff\x93\xa4\xea\xee\xbd\x3b"
+			"\x78\xa9\x34\x38\xa6\xf6\x2a\x92"
+			"\xab\x59\x59\xc8\x59\xe6\x82\xb7"
+			"\x2c\x7d\xef\x40\x61\x97\xca\x4d",
+	}, {
+		.ksize     = 64,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06",
+		.psize     = 7,
+		.digest    =
+			"\x44\xae\x55\x0a\x1c\x3b\xd3\x81"
+			"\x7d\xc8\x43\x53\x05\xb6\xd1\xbb"
+			"\x5d\x7f\x64\x3e\xd5\x22\x49\x91"
+			"\xfb\x3e\x91\x7a\xae\x0b\x26\xdb",
+	}, {
+		.ksize     = 1,
+		.key       =
+			"\x42",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e",
+		.psize     = 15,
+		.digest    =
+			"\x10\x03\x69\xe4\x5f\xc4\x20\x96"
+			"\x57\xa0\x01\x2d\x16\xed\xfa\xbe"
+			"\xd6\xe7\x1a\xe7\x1e\x61\x98\xc4"
+			"\x6e\x0e\x42\x8b\x21\x7f\x77\x27",
+	}, {
+		.ksize     = 32,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47"
+			"\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
+			"\x50\x51\x52\x53\x54\x55\x56\x57"
+			"\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
+			"\x60\x61\x62\x63\x64\x65\x66\x67"
+			"\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77"
+			"\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87"
+			"\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97"
+			"\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7"
+			"\xa8\xa9\xaa\xab\xac\xad\xae\xaf"
+			"\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7"
+			"\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7"
+			"\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7"
+			"\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7"
+			"\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6",
+		.psize     = 247,
+		.digest    =
+			"\x40\x9f\xf7\x1a\xeb\x38\xb3\x58"
+			"\xd7\xc6\x0a\x3f\x6e\x9f\xe9\x13"
+			"\x14\x31\x49\x2a\x6e\xaa\x2b\xbd"
+			"\x2a\x88\xbf\x2a\x77\x83\x86\x3e",
+	}, {
+		.ksize     = 64,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47"
+			"\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
+			"\x50\x51\x52\x53\x54\x55\x56\x57"
+			"\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
+			"\x60\x61\x62\x63\x64\x65\x66\x67"
+			"\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77"
+			"\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87"
+			"\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97"
+			"\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7"
+			"\xa8\xa9\xaa\xab\xac\xad\xae\xaf"
+			"\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7"
+			"\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7"
+			"\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7"
+			"\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7"
+			"\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7"
+			"\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff",
+		.psize     = 256,
+		.digest    =
+			"\x1e\xe3\xb6\x31\x2b\x4e\x0f\x0b"
+			"\x96\x63\xb8\x12\xb8\xc1\x29\xe6"
+			"\xd4\x5c\x41\x0b\x1c\x9c\x5a\x16"
+			"\x67\xbf\xc6\xdd\x95\x1d\xb7\x9f",
+	}
+};
+
+static const struct hash_testvec blake2b_384_tv_template[] = {
+	{
+		.plaintext =
+			"",
+		.psize     = 0,
+		.digest    =
+			"\xb3\x28\x11\x42\x33\x77\xf5\x2d"
+			"\x78\x62\x28\x6e\xe1\xa7\x2e\xe5"
+			"\x40\x52\x43\x80\xfd\xa1\x72\x4a"
+			"\x6f\x25\xd7\x97\x8c\x6f\xd3\x24"
+			"\x4a\x6c\xaf\x04\x98\x81\x26\x73"
+			"\xc5\xe0\x5e\xf5\x83\x82\x51\x00",
+	}, {
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.psize     = 64,
+		.digest    =
+			"\x11\xc8\xe1\xa6\xad\x99\xf7\x5b"
+			"\xd0\xb8\xdf\x15\x30\x54\x9c\x6b"
+			"\xf2\xe7\x2d\x64\xe6\x70\x35\x35"
+			"\xad\x06\x51\x24\x17\xb0\xf3\x35"
+			"\xdf\xe0\x7e\x63\xcc\xb8\xc5\xcf"
+			"\x99\xd7\x6e\xe1\xf6\x53\xf6\x09",
+	}, {
+		.ksize     = 32,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f",
+		.plaintext =
+			"\x00",
+		.psize     = 1,
+		.digest    =
+			"\xf7\x5c\xa8\x93\x2f\x14\xb5\xf2"
+			"\x8e\x7b\xe1\xc2\x77\xa0\xec\x04"
+			"\x1d\x8e\x24\xd0\x4e\x11\xd4\x5b"
+			"\xe4\x95\x2a\x86\xdc\xce\x95\x99"
+			"\x32\xb2\x4d\x15\xd3\xd3\x36\xc2"
+			"\x70\x58\xc2\x19\xf5\x9f\xe8\xe1",
+	}, {
+		.ksize     = 64,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06",
+		.psize     = 7,
+		.digest    =
+			"\xa2\xc9\x4a\x59\xbc\x66\xbf\x9b"
+			"\x7f\x3f\xe2\x4a\xab\xfb\x80\x5a"
+			"\x0a\xbb\xb4\xf5\x86\x9a\x7e\x7b"
+			"\x47\x2f\x5e\x6b\x73\x6d\x34\x4d"
+			"\xf4\xc3\x9c\x63\xe7\x20\x6d\x07"
+			"\x53\x6b\xe6\x3d\x78\xb6\xf1\xb0",
+	}, {
+		.ksize     = 1,
+		.key       =
+			"\x42",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e",
+		.psize     = 15,
+		.digest    =
+			"\xa5\x89\xf8\x8f\x49\x5f\xe0\x2d"
+			"\xee\x38\x98\xaa\xc0\x80\xfd\x7a"
+			"\x42\x28\xf5\x65\xb3\x3e\x92\xb7"
+			"\x08\x00\x84\x69\x65\x95\xf7\xb9"
+			"\xa9\x66\xb7\xb0\x69\xe8\xa8\x45"
+			"\x7e\xe0\xec\xd9\x35\x56\xc0\x63",
+	}, {
+		.ksize     = 32,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47"
+			"\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
+			"\x50\x51\x52\x53\x54\x55\x56\x57"
+			"\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
+			"\x60\x61\x62\x63\x64\x65\x66\x67"
+			"\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77"
+			"\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87"
+			"\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97"
+			"\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7"
+			"\xa8\xa9\xaa\xab\xac\xad\xae\xaf"
+			"\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7"
+			"\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7"
+			"\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7"
+			"\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7"
+			"\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6",
+		.psize     = 247,
+		.digest    =
+			"\x14\x5d\x5a\xc5\x98\x3c\x04\x4b"
+			"\xe2\x51\x5f\x26\x6e\xd2\x01\x0a"
+			"\x8a\xcb\xa9\xc3\x7b\xd1\xea\x6f"
+			"\x94\xe9\x24\xcc\x10\x45\xb4\x26"
+			"\xb2\x55\x17\x3f\xfa\x28\x92\xab"
+			"\x61\x62\x97\x14\x7d\x17\x57\x3b",
+	}, {
+		.ksize     = 64,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47"
+			"\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
+			"\x50\x51\x52\x53\x54\x55\x56\x57"
+			"\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
+			"\x60\x61\x62\x63\x64\x65\x66\x67"
+			"\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77"
+			"\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87"
+			"\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97"
+			"\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7"
+			"\xa8\xa9\xaa\xab\xac\xad\xae\xaf"
+			"\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7"
+			"\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7"
+			"\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7"
+			"\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7"
+			"\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7"
+			"\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff",
+		.psize     = 256,
+		.digest    =
+			"\xdf\x0b\x34\x2a\xb6\x14\xf4\xca"
+			"\x66\x45\x83\x82\x97\x94\xed\x4b"
+			"\xe2\x11\x0b\x2b\x68\x20\x08\x7e"
+			"\xe9\xdd\xfc\x7c\x3d\xc2\x0d\x2f"
+			"\x66\x35\x62\x7a\x6e\x97\x7a\x00"
+			"\x3e\x3d\xd7\x78\x4c\x30\x20\x19",
+	}
+};
+
+static const struct hash_testvec blake2b_512_tv_template[] = {
+	{
+		.plaintext =
+			"",
+		.psize     = 0,
+		.digest    =
+			"\x78\x6a\x02\xf7\x42\x01\x59\x03"
+			"\xc6\xc6\xfd\x85\x25\x52\xd2\x72"
+			"\x91\x2f\x47\x40\xe1\x58\x47\x61"
+			"\x8a\x86\xe2\x17\xf7\x1f\x54\x19"
+			"\xd2\x5e\x10\x31\xaf\xee\x58\x53"
+			"\x13\x89\x64\x44\x93\x4e\xb0\x4b"
+			"\x90\x3a\x68\x5b\x14\x48\xb7\x55"
+			"\xd5\x6f\x70\x1a\xfe\x9b\xe2\xce",
+	}, {
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.psize     = 64,
+		.digest    =
+			"\x2f\xc6\xe6\x9f\xa2\x6a\x89\xa5"
+			"\xed\x26\x90\x92\xcb\x9b\x2a\x44"
+			"\x9a\x44\x09\xa7\xa4\x40\x11\xee"
+			"\xca\xd1\x3d\x7c\x4b\x04\x56\x60"
+			"\x2d\x40\x2f\xa5\x84\x4f\x1a\x7a"
+			"\x75\x81\x36\xce\x3d\x5d\x8d\x0e"
+			"\x8b\x86\x92\x1f\xff\xf4\xf6\x92"
+			"\xdd\x95\xbd\xc8\xe5\xff\x00\x52",
+	}, {
+		.ksize     = 32,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f",
+		.plaintext =
+			"\x00",
+		.psize     = 1,
+		.digest    =
+			"\xf4\xc3\x55\xc6\x1f\xb4\xa9\x61"
+			"\x1c\xf0\x8a\xe5\x3a\x06\xf5\x7e"
+			"\x25\xc6\xe9\xc3\xbb\x7a\x88\x18"
+			"\xb9\x53\x9d\xc4\xb4\xe6\xd7\x05"
+			"\x4b\x62\x99\x9b\xbe\xf5\x21\x2d"
+			"\xea\x91\x03\xa2\xc4\xe4\x4d\x65"
+			"\x04\x65\x9d\x60\xb5\x04\x55\x3a"
+			"\xd1\x17\x3c\x02\xc4\x55\x3a\xfd",
+	}, {
+		.ksize     = 64,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06",
+		.psize     = 7,
+		.digest    =
+			"\x7a\x8c\xfe\x9b\x90\xf7\x5f\x7e"
+			"\xcb\x3a\xcc\x05\x3a\xae\xd6\x19"
+			"\x31\x12\xb6\xf6\xa4\xae\xeb\x3f"
+			"\x65\xd3\xde\x54\x19\x42\xde\xb9"
+			"\xe2\x22\x81\x52\xa3\xc4\xbb\xbe"
+			"\x72\xfc\x3b\x12\x62\x95\x28\xcf"
+			"\xbb\x09\xfe\x63\x0f\x04\x74\x33"
+			"\x9f\x54\xab\xf4\x53\xe2\xed\x52",
+	}, {
+		.ksize     = 1,
+		.key       =
+			"\x42",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e",
+		.psize     = 15,
+		.digest    =
+			"\xb3\xac\xd9\xa6\xbc\x00\x92\x43"
+			"\x12\x3e\xbe\xc8\xa2\x1a\x04\xd9"
+			"\x5a\xf2\x61\x4b\x2b\x60\xdc\x6f"
+			"\x23\xa1\x52\x1e\xf3\xa0\xc6\xf9"
+			"\xda\xb2\xdd\x47\x43\x12\x67\xe0"
+			"\x62\x0a\xba\xf1\x90\x67\xcc\x45"
+			"\x01\x9c\x06\x99\xc4\x45\x98\xf2"
+			"\x6a\xf0\x45\x99\x5b\xfb\x99\x10",
+	}, {
+		.ksize     = 32,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47"
+			"\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
+			"\x50\x51\x52\x53\x54\x55\x56\x57"
+			"\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
+			"\x60\x61\x62\x63\x64\x65\x66\x67"
+			"\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77"
+			"\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87"
+			"\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97"
+			"\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7"
+			"\xa8\xa9\xaa\xab\xac\xad\xae\xaf"
+			"\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7"
+			"\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7"
+			"\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7"
+			"\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7"
+			"\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6",
+		.psize     = 247,
+		.digest    =
+			"\x4c\x13\x91\xb7\x59\x96\xd3\x28"
+			"\xd2\x63\xd1\x87\x1a\xbf\xe9\x36"
+			"\xe2\x49\x98\x66\xb6\x60\x9a\x07"
+			"\xa0\x4f\x78\x75\x57\x6d\x63\x0a"
+			"\xcf\xca\x48\x51\xfc\x3c\x79\x1e"
+			"\x1f\xf6\x3a\x73\x86\x64\x77\x15"
+			"\xd9\x7c\xf8\xd7\x0d\x13\x2e\x27"
+			"\x76\x9f\x3c\x10\x40\xdf\x66\x81",
+	}, {
+		.ksize     = 64,
+		.key       =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f",
+		.plaintext =
+			"\x00\x01\x02\x03\x04\x05\x06\x07"
+			"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17"
+			"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27"
+			"\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37"
+			"\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47"
+			"\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
+			"\x50\x51\x52\x53\x54\x55\x56\x57"
+			"\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
+			"\x60\x61\x62\x63\x64\x65\x66\x67"
+			"\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77"
+			"\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87"
+			"\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97"
+			"\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7"
+			"\xa8\xa9\xaa\xab\xac\xad\xae\xaf"
+			"\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7"
+			"\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7"
+			"\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7"
+			"\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7"
+			"\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7"
+			"\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff",
+		.psize     = 256,
+		.digest    =
+			"\xb7\x20\x71\xe0\x96\x27\x7e\xde"
+			"\xbb\x8e\xe5\x13\x4d\xd3\x71\x49"
+			"\x96\x30\x7b\xa3\xa5\x5a\xa4\x73"
+			"\x3d\x41\x2a\xbb\xe2\x8e\x90\x9e"
+			"\x10\xe5\x7e\x6f\xbf\xb4\xef\x53"
+			"\xb3\xb9\x60\x51\x82\x94\xff\x88"
+			"\x9a\x90\x82\x92\x54\x41\x2e\x2a"
+			"\x60\xb8\x5a\xdd\x07\xa3\x67\x4f",
+	}
+};
+
 #endif	/* _CRYPTO_TESTMGR_H */
-- 
2.23.0

