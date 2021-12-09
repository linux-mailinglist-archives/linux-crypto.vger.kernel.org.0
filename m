Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D2746E4E0
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Dec 2021 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhLIJID (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Dec 2021 04:08:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35460 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbhLIJH6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Dec 2021 04:07:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D3CA1FD2A;
        Thu,  9 Dec 2021 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2PmMOoWX2ZD7tkumMKdT8tHz0NDdJiIWKaoqpDxZiw=;
        b=mEowSEIwj+qFqP7BDSRdQlX6+POprt0bfrfKYkt/MXoPieQDTGCAZHeyheDu/rAABqQzdc
        NPHNEZZdtQV25L6axHhZlPNSwKVUQTASfeaWURwdJwMV8aqhZvhrDzWfKLROJVD3cBwGKp
        SZtumzRBWdOV+UAS5gXhDzmZph8wqo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040664;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2PmMOoWX2ZD7tkumMKdT8tHz0NDdJiIWKaoqpDxZiw=;
        b=xFo0xtIOGsS0P7/R8z1hglP3acg59dkZDYYrgQ8xdM0iRc1iihnfQyiSN/9JYXfkoYwabW
        oJ/gHxI352hSczBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35A1913A86;
        Thu,  9 Dec 2021 09:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OJBdC5jGsWGjaQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:24 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH v2 06/18] crypto: dh - introduce RFC 3526 safe-prime groups
Date:   Thu,  9 Dec 2021 10:03:46 +0100
Message-Id: <20211209090358.28231-7-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

A future patch will make the DH implementation to reject domain parameters
not corresponding to any of the safe-prime groups approved by SP800-56Arev3
in FIPS mode.

The MODP groups specified by RFC 3526 are among those approved safe-prime
groups. Make them known to the kernel in order to enable the DH
implementation to recognize those when passed in from e.g. the
keyctl(KEYCTL_DH_COMPUTE) syscall.

More specifically, introduce corresponding members to enum dh_group_id
as well as entries with the resp. domain parameters to the
safe_prime_groups[] array queried by crypto_dh_decode_key(). The resp.
->max_strength value is set to the maximum supported security strength as
specified in SP800-56Arev3.

As the domain parameters consume an substantial amount of space, make
RFC 3526 safe-prime group support selectable by means of the new
CRYPTO_DH_GROUPS_RFC3526 Kconfig option.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/Kconfig      |   6 ++
 crypto/dh_helper.c  | 216 ++++++++++++++++++++++++++++++++++++++++++++
 include/crypto/dh.h |   7 ++
 3 files changed, 229 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 0f039bbf36e2..fcb044bdc90a 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -238,6 +238,12 @@ config CRYPTO_DH_GROUPS_RFC7919
 	  Enable to allow for the use of RFC 7919 DH parameters in FIPS mode,
 	  e.g. via keyctl(KEYCTL_DH_COMPUTE). Otherwise it's safe to say N.
 
+config CRYPTO_DH_GROUPS_RFC3526
+	bool "Support for RFC 3526 MODP group parameters"
+	help
+	  Enable to allow for the use of RFC 3526 DH parameters in FIPS mode,
+	  e.g. via keyctl(KEYCTL_DH_COMPUTE). Otherwise it's safe to say N.
+
 endif
 
 config CRYPTO_ECC
diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index b6df9207bcfd..4541a4b1a92f 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -235,6 +235,222 @@ static const struct safe_prime_group
 	"\xd6\x8c\x8b\xb7\xc5\xc6\x42\x4c\xff\xff\xff\xff\xff\xff\xff\xff",
 	},
 #endif /* CONFIG_CRYPTO_DH_GROUPS_RFC7919 */
+#ifdef CONFIG_CRYPTO_DH_GROUPS_RFC3526
+	{
+	.group_id = DH_GROUP_ID_MODP2048,
+	.max_strength = 112,
+	.p_size = 256,
+	.p =
+	"\xff\xff\xff\xff\xff\xff\xff\xff\xc9\x0f\xda\xa2\x21\x68\xc2\x34"
+	"\xc4\xc6\x62\x8b\x80\xdc\x1c\xd1\x29\x02\x4e\x08\x8a\x67\xcc\x74"
+	"\x02\x0b\xbe\xa6\x3b\x13\x9b\x22\x51\x4a\x08\x79\x8e\x34\x04\xdd"
+	"\xef\x95\x19\xb3\xcd\x3a\x43\x1b\x30\x2b\x0a\x6d\xf2\x5f\x14\x37"
+	"\x4f\xe1\x35\x6d\x6d\x51\xc2\x45\xe4\x85\xb5\x76\x62\x5e\x7e\xc6"
+	"\xf4\x4c\x42\xe9\xa6\x37\xed\x6b\x0b\xff\x5c\xb6\xf4\x06\xb7\xed"
+	"\xee\x38\x6b\xfb\x5a\x89\x9f\xa5\xae\x9f\x24\x11\x7c\x4b\x1f\xe6"
+	"\x49\x28\x66\x51\xec\xe4\x5b\x3d\xc2\x00\x7c\xb8\xa1\x63\xbf\x05"
+	"\x98\xda\x48\x36\x1c\x55\xd3\x9a\x69\x16\x3f\xa8\xfd\x24\xcf\x5f"
+	"\x83\x65\x5d\x23\xdc\xa3\xad\x96\x1c\x62\xf3\x56\x20\x85\x52\xbb"
+	"\x9e\xd5\x29\x07\x70\x96\x96\x6d\x67\x0c\x35\x4e\x4a\xbc\x98\x04"
+	"\xf1\x74\x6c\x08\xca\x18\x21\x7c\x32\x90\x5e\x46\x2e\x36\xce\x3b"
+	"\xe3\x9e\x77\x2c\x18\x0e\x86\x03\x9b\x27\x83\xa2\xec\x07\xa2\x8f"
+	"\xb5\xc5\x5d\xf0\x6f\x4c\x52\xc9\xde\x2b\xcb\xf6\x95\x58\x17\x18"
+	"\x39\x95\x49\x7c\xea\x95\x6a\xe5\x15\xd2\x26\x18\x98\xfa\x05\x10"
+	"\x15\x72\x8e\x5a\x8a\xac\xaa\x68\xff\xff\xff\xff\xff\xff\xff\xff",
+	},
+	{
+	.group_id = DH_GROUP_ID_MODP3072,
+	.max_strength = 128,
+	.p_size = 384,
+	.p =
+	"\xff\xff\xff\xff\xff\xff\xff\xff\xc9\x0f\xda\xa2\x21\x68\xc2\x34"
+	"\xc4\xc6\x62\x8b\x80\xdc\x1c\xd1\x29\x02\x4e\x08\x8a\x67\xcc\x74"
+	"\x02\x0b\xbe\xa6\x3b\x13\x9b\x22\x51\x4a\x08\x79\x8e\x34\x04\xdd"
+	"\xef\x95\x19\xb3\xcd\x3a\x43\x1b\x30\x2b\x0a\x6d\xf2\x5f\x14\x37"
+	"\x4f\xe1\x35\x6d\x6d\x51\xc2\x45\xe4\x85\xb5\x76\x62\x5e\x7e\xc6"
+	"\xf4\x4c\x42\xe9\xa6\x37\xed\x6b\x0b\xff\x5c\xb6\xf4\x06\xb7\xed"
+	"\xee\x38\x6b\xfb\x5a\x89\x9f\xa5\xae\x9f\x24\x11\x7c\x4b\x1f\xe6"
+	"\x49\x28\x66\x51\xec\xe4\x5b\x3d\xc2\x00\x7c\xb8\xa1\x63\xbf\x05"
+	"\x98\xda\x48\x36\x1c\x55\xd3\x9a\x69\x16\x3f\xa8\xfd\x24\xcf\x5f"
+	"\x83\x65\x5d\x23\xdc\xa3\xad\x96\x1c\x62\xf3\x56\x20\x85\x52\xbb"
+	"\x9e\xd5\x29\x07\x70\x96\x96\x6d\x67\x0c\x35\x4e\x4a\xbc\x98\x04"
+	"\xf1\x74\x6c\x08\xca\x18\x21\x7c\x32\x90\x5e\x46\x2e\x36\xce\x3b"
+	"\xe3\x9e\x77\x2c\x18\x0e\x86\x03\x9b\x27\x83\xa2\xec\x07\xa2\x8f"
+	"\xb5\xc5\x5d\xf0\x6f\x4c\x52\xc9\xde\x2b\xcb\xf6\x95\x58\x17\x18"
+	"\x39\x95\x49\x7c\xea\x95\x6a\xe5\x15\xd2\x26\x18\x98\xfa\x05\x10"
+	"\x15\x72\x8e\x5a\x8a\xaa\xc4\x2d\xad\x33\x17\x0d\x04\x50\x7a\x33"
+	"\xa8\x55\x21\xab\xdf\x1c\xba\x64\xec\xfb\x85\x04\x58\xdb\xef\x0a"
+	"\x8a\xea\x71\x57\x5d\x06\x0c\x7d\xb3\x97\x0f\x85\xa6\xe1\xe4\xc7"
+	"\xab\xf5\xae\x8c\xdb\x09\x33\xd7\x1e\x8c\x94\xe0\x4a\x25\x61\x9d"
+	"\xce\xe3\xd2\x26\x1a\xd2\xee\x6b\xf1\x2f\xfa\x06\xd9\x8a\x08\x64"
+	"\xd8\x76\x02\x73\x3e\xc8\x6a\x64\x52\x1f\x2b\x18\x17\x7b\x20\x0c"
+	"\xbb\xe1\x17\x57\x7a\x61\x5d\x6c\x77\x09\x88\xc0\xba\xd9\x46\xe2"
+	"\x08\xe2\x4f\xa0\x74\xe5\xab\x31\x43\xdb\x5b\xfc\xe0\xfd\x10\x8e"
+	"\x4b\x82\xd1\x20\xa9\x3a\xd2\xca\xff\xff\xff\xff\xff\xff\xff\xff",
+	},
+	{
+	.group_id = DH_GROUP_ID_MODP4096,
+	.max_strength = 152,
+	.p_size = 512,
+	.p =
+	"\xff\xff\xff\xff\xff\xff\xff\xff\xc9\x0f\xda\xa2\x21\x68\xc2\x34"
+	"\xc4\xc6\x62\x8b\x80\xdc\x1c\xd1\x29\x02\x4e\x08\x8a\x67\xcc\x74"
+	"\x02\x0b\xbe\xa6\x3b\x13\x9b\x22\x51\x4a\x08\x79\x8e\x34\x04\xdd"
+	"\xef\x95\x19\xb3\xcd\x3a\x43\x1b\x30\x2b\x0a\x6d\xf2\x5f\x14\x37"
+	"\x4f\xe1\x35\x6d\x6d\x51\xc2\x45\xe4\x85\xb5\x76\x62\x5e\x7e\xc6"
+	"\xf4\x4c\x42\xe9\xa6\x37\xed\x6b\x0b\xff\x5c\xb6\xf4\x06\xb7\xed"
+	"\xee\x38\x6b\xfb\x5a\x89\x9f\xa5\xae\x9f\x24\x11\x7c\x4b\x1f\xe6"
+	"\x49\x28\x66\x51\xec\xe4\x5b\x3d\xc2\x00\x7c\xb8\xa1\x63\xbf\x05"
+	"\x98\xda\x48\x36\x1c\x55\xd3\x9a\x69\x16\x3f\xa8\xfd\x24\xcf\x5f"
+	"\x83\x65\x5d\x23\xdc\xa3\xad\x96\x1c\x62\xf3\x56\x20\x85\x52\xbb"
+	"\x9e\xd5\x29\x07\x70\x96\x96\x6d\x67\x0c\x35\x4e\x4a\xbc\x98\x04"
+	"\xf1\x74\x6c\x08\xca\x18\x21\x7c\x32\x90\x5e\x46\x2e\x36\xce\x3b"
+	"\xe3\x9e\x77\x2c\x18\x0e\x86\x03\x9b\x27\x83\xa2\xec\x07\xa2\x8f"
+	"\xb5\xc5\x5d\xf0\x6f\x4c\x52\xc9\xde\x2b\xcb\xf6\x95\x58\x17\x18"
+	"\x39\x95\x49\x7c\xea\x95\x6a\xe5\x15\xd2\x26\x18\x98\xfa\x05\x10"
+	"\x15\x72\x8e\x5a\x8a\xaa\xc4\x2d\xad\x33\x17\x0d\x04\x50\x7a\x33"
+	"\xa8\x55\x21\xab\xdf\x1c\xba\x64\xec\xfb\x85\x04\x58\xdb\xef\x0a"
+	"\x8a\xea\x71\x57\x5d\x06\x0c\x7d\xb3\x97\x0f\x85\xa6\xe1\xe4\xc7"
+	"\xab\xf5\xae\x8c\xdb\x09\x33\xd7\x1e\x8c\x94\xe0\x4a\x25\x61\x9d"
+	"\xce\xe3\xd2\x26\x1a\xd2\xee\x6b\xf1\x2f\xfa\x06\xd9\x8a\x08\x64"
+	"\xd8\x76\x02\x73\x3e\xc8\x6a\x64\x52\x1f\x2b\x18\x17\x7b\x20\x0c"
+	"\xbb\xe1\x17\x57\x7a\x61\x5d\x6c\x77\x09\x88\xc0\xba\xd9\x46\xe2"
+	"\x08\xe2\x4f\xa0\x74\xe5\xab\x31\x43\xdb\x5b\xfc\xe0\xfd\x10\x8e"
+	"\x4b\x82\xd1\x20\xa9\x21\x08\x01\x1a\x72\x3c\x12\xa7\x87\xe6\xd7"
+	"\x88\x71\x9a\x10\xbd\xba\x5b\x26\x99\xc3\x27\x18\x6a\xf4\xe2\x3c"
+	"\x1a\x94\x68\x34\xb6\x15\x0b\xda\x25\x83\xe9\xca\x2a\xd4\x4c\xe8"
+	"\xdb\xbb\xc2\xdb\x04\xde\x8e\xf9\x2e\x8e\xfc\x14\x1f\xbe\xca\xa6"
+	"\x28\x7c\x59\x47\x4e\x6b\xc0\x5d\x99\xb2\x96\x4f\xa0\x90\xc3\xa2"
+	"\x23\x3b\xa1\x86\x51\x5b\xe7\xed\x1f\x61\x29\x70\xce\xe2\xd7\xaf"
+	"\xb8\x1b\xdd\x76\x21\x70\x48\x1c\xd0\x06\x91\x27\xd5\xb0\x5a\xa9"
+	"\x93\xb4\xea\x98\x8d\x8f\xdd\xc1\x86\xff\xb7\xdc\x90\xa6\xc0\x8f"
+	"\x4d\xf4\x35\xc9\x34\x06\x31\x99\xff\xff\xff\xff\xff\xff\xff\xff",
+	},
+	{
+	.group_id = DH_GROUP_ID_MODP6144,
+	.max_strength = 176,
+	.p_size = 768,
+	.p =
+	"\xff\xff\xff\xff\xff\xff\xff\xff\xc9\x0f\xda\xa2\x21\x68\xc2\x34"
+	"\xc4\xc6\x62\x8b\x80\xdc\x1c\xd1\x29\x02\x4e\x08\x8a\x67\xcc\x74"
+	"\x02\x0b\xbe\xa6\x3b\x13\x9b\x22\x51\x4a\x08\x79\x8e\x34\x04\xdd"
+	"\xef\x95\x19\xb3\xcd\x3a\x43\x1b\x30\x2b\x0a\x6d\xf2\x5f\x14\x37"
+	"\x4f\xe1\x35\x6d\x6d\x51\xc2\x45\xe4\x85\xb5\x76\x62\x5e\x7e\xc6"
+	"\xf4\x4c\x42\xe9\xa6\x37\xed\x6b\x0b\xff\x5c\xb6\xf4\x06\xb7\xed"
+	"\xee\x38\x6b\xfb\x5a\x89\x9f\xa5\xae\x9f\x24\x11\x7c\x4b\x1f\xe6"
+	"\x49\x28\x66\x51\xec\xe4\x5b\x3d\xc2\x00\x7c\xb8\xa1\x63\xbf\x05"
+	"\x98\xda\x48\x36\x1c\x55\xd3\x9a\x69\x16\x3f\xa8\xfd\x24\xcf\x5f"
+	"\x83\x65\x5d\x23\xdc\xa3\xad\x96\x1c\x62\xf3\x56\x20\x85\x52\xbb"
+	"\x9e\xd5\x29\x07\x70\x96\x96\x6d\x67\x0c\x35\x4e\x4a\xbc\x98\x04"
+	"\xf1\x74\x6c\x08\xca\x18\x21\x7c\x32\x90\x5e\x46\x2e\x36\xce\x3b"
+	"\xe3\x9e\x77\x2c\x18\x0e\x86\x03\x9b\x27\x83\xa2\xec\x07\xa2\x8f"
+	"\xb5\xc5\x5d\xf0\x6f\x4c\x52\xc9\xde\x2b\xcb\xf6\x95\x58\x17\x18"
+	"\x39\x95\x49\x7c\xea\x95\x6a\xe5\x15\xd2\x26\x18\x98\xfa\x05\x10"
+	"\x15\x72\x8e\x5a\x8a\xaa\xc4\x2d\xad\x33\x17\x0d\x04\x50\x7a\x33"
+	"\xa8\x55\x21\xab\xdf\x1c\xba\x64\xec\xfb\x85\x04\x58\xdb\xef\x0a"
+	"\x8a\xea\x71\x57\x5d\x06\x0c\x7d\xb3\x97\x0f\x85\xa6\xe1\xe4\xc7"
+	"\xab\xf5\xae\x8c\xdb\x09\x33\xd7\x1e\x8c\x94\xe0\x4a\x25\x61\x9d"
+	"\xce\xe3\xd2\x26\x1a\xd2\xee\x6b\xf1\x2f\xfa\x06\xd9\x8a\x08\x64"
+	"\xd8\x76\x02\x73\x3e\xc8\x6a\x64\x52\x1f\x2b\x18\x17\x7b\x20\x0c"
+	"\xbb\xe1\x17\x57\x7a\x61\x5d\x6c\x77\x09\x88\xc0\xba\xd9\x46\xe2"
+	"\x08\xe2\x4f\xa0\x74\xe5\xab\x31\x43\xdb\x5b\xfc\xe0\xfd\x10\x8e"
+	"\x4b\x82\xd1\x20\xa9\x21\x08\x01\x1a\x72\x3c\x12\xa7\x87\xe6\xd7"
+	"\x88\x71\x9a\x10\xbd\xba\x5b\x26\x99\xc3\x27\x18\x6a\xf4\xe2\x3c"
+	"\x1a\x94\x68\x34\xb6\x15\x0b\xda\x25\x83\xe9\xca\x2a\xd4\x4c\xe8"
+	"\xdb\xbb\xc2\xdb\x04\xde\x8e\xf9\x2e\x8e\xfc\x14\x1f\xbe\xca\xa6"
+	"\x28\x7c\x59\x47\x4e\x6b\xc0\x5d\x99\xb2\x96\x4f\xa0\x90\xc3\xa2"
+	"\x23\x3b\xa1\x86\x51\x5b\xe7\xed\x1f\x61\x29\x70\xce\xe2\xd7\xaf"
+	"\xb8\x1b\xdd\x76\x21\x70\x48\x1c\xd0\x06\x91\x27\xd5\xb0\x5a\xa9"
+	"\x93\xb4\xea\x98\x8d\x8f\xdd\xc1\x86\xff\xb7\xdc\x90\xa6\xc0\x8f"
+	"\x4d\xf4\x35\xc9\x34\x02\x84\x92\x36\xc3\xfa\xb4\xd2\x7c\x70\x26"
+	"\xc1\xd4\xdc\xb2\x60\x26\x46\xde\xc9\x75\x1e\x76\x3d\xba\x37\xbd"
+	"\xf8\xff\x94\x06\xad\x9e\x53\x0e\xe5\xdb\x38\x2f\x41\x30\x01\xae"
+	"\xb0\x6a\x53\xed\x90\x27\xd8\x31\x17\x97\x27\xb0\x86\x5a\x89\x18"
+	"\xda\x3e\xdb\xeb\xcf\x9b\x14\xed\x44\xce\x6c\xba\xce\xd4\xbb\x1b"
+	"\xdb\x7f\x14\x47\xe6\xcc\x25\x4b\x33\x20\x51\x51\x2b\xd7\xaf\x42"
+	"\x6f\xb8\xf4\x01\x37\x8c\xd2\xbf\x59\x83\xca\x01\xc6\x4b\x92\xec"
+	"\xf0\x32\xea\x15\xd1\x72\x1d\x03\xf4\x82\xd7\xce\x6e\x74\xfe\xf6"
+	"\xd5\x5e\x70\x2f\x46\x98\x0c\x82\xb5\xa8\x40\x31\x90\x0b\x1c\x9e"
+	"\x59\xe7\xc9\x7f\xbe\xc7\xe8\xf3\x23\xa9\x7a\x7e\x36\xcc\x88\xbe"
+	"\x0f\x1d\x45\xb7\xff\x58\x5a\xc5\x4b\xd4\x07\xb2\x2b\x41\x54\xaa"
+	"\xcc\x8f\x6d\x7e\xbf\x48\xe1\xd8\x14\xcc\x5e\xd2\x0f\x80\x37\xe0"
+	"\xa7\x97\x15\xee\xf2\x9b\xe3\x28\x06\xa1\xd5\x8b\xb7\xc5\xda\x76"
+	"\xf5\x50\xaa\x3d\x8a\x1f\xbf\xf0\xeb\x19\xcc\xb1\xa3\x13\xd5\x5c"
+	"\xda\x56\xc9\xec\x2e\xf2\x96\x32\x38\x7f\xe8\xd7\x6e\x3c\x04\x68"
+	"\x04\x3e\x8f\x66\x3f\x48\x60\xee\x12\xbf\x2d\x5b\x0b\x74\x74\xd6"
+	"\xe6\x94\xf9\x1e\x6d\xcc\x40\x24\xff\xff\xff\xff\xff\xff\xff\xff",
+	},
+	{
+	.group_id = DH_GROUP_ID_MODP8192,
+	.max_strength = 200,
+	.p_size = 1024,
+	.p =
+	"\xff\xff\xff\xff\xff\xff\xff\xff\xc9\x0f\xda\xa2\x21\x68\xc2\x34"
+	"\xc4\xc6\x62\x8b\x80\xdc\x1c\xd1\x29\x02\x4e\x08\x8a\x67\xcc\x74"
+	"\x02\x0b\xbe\xa6\x3b\x13\x9b\x22\x51\x4a\x08\x79\x8e\x34\x04\xdd"
+	"\xef\x95\x19\xb3\xcd\x3a\x43\x1b\x30\x2b\x0a\x6d\xf2\x5f\x14\x37"
+	"\x4f\xe1\x35\x6d\x6d\x51\xc2\x45\xe4\x85\xb5\x76\x62\x5e\x7e\xc6"
+	"\xf4\x4c\x42\xe9\xa6\x37\xed\x6b\x0b\xff\x5c\xb6\xf4\x06\xb7\xed"
+	"\xee\x38\x6b\xfb\x5a\x89\x9f\xa5\xae\x9f\x24\x11\x7c\x4b\x1f\xe6"
+	"\x49\x28\x66\x51\xec\xe4\x5b\x3d\xc2\x00\x7c\xb8\xa1\x63\xbf\x05"
+	"\x98\xda\x48\x36\x1c\x55\xd3\x9a\x69\x16\x3f\xa8\xfd\x24\xcf\x5f"
+	"\x83\x65\x5d\x23\xdc\xa3\xad\x96\x1c\x62\xf3\x56\x20\x85\x52\xbb"
+	"\x9e\xd5\x29\x07\x70\x96\x96\x6d\x67\x0c\x35\x4e\x4a\xbc\x98\x04"
+	"\xf1\x74\x6c\x08\xca\x18\x21\x7c\x32\x90\x5e\x46\x2e\x36\xce\x3b"
+	"\xe3\x9e\x77\x2c\x18\x0e\x86\x03\x9b\x27\x83\xa2\xec\x07\xa2\x8f"
+	"\xb5\xc5\x5d\xf0\x6f\x4c\x52\xc9\xde\x2b\xcb\xf6\x95\x58\x17\x18"
+	"\x39\x95\x49\x7c\xea\x95\x6a\xe5\x15\xd2\x26\x18\x98\xfa\x05\x10"
+	"\x15\x72\x8e\x5a\x8a\xaa\xc4\x2d\xad\x33\x17\x0d\x04\x50\x7a\x33"
+	"\xa8\x55\x21\xab\xdf\x1c\xba\x64\xec\xfb\x85\x04\x58\xdb\xef\x0a"
+	"\x8a\xea\x71\x57\x5d\x06\x0c\x7d\xb3\x97\x0f\x85\xa6\xe1\xe4\xc7"
+	"\xab\xf5\xae\x8c\xdb\x09\x33\xd7\x1e\x8c\x94\xe0\x4a\x25\x61\x9d"
+	"\xce\xe3\xd2\x26\x1a\xd2\xee\x6b\xf1\x2f\xfa\x06\xd9\x8a\x08\x64"
+	"\xd8\x76\x02\x73\x3e\xc8\x6a\x64\x52\x1f\x2b\x18\x17\x7b\x20\x0c"
+	"\xbb\xe1\x17\x57\x7a\x61\x5d\x6c\x77\x09\x88\xc0\xba\xd9\x46\xe2"
+	"\x08\xe2\x4f\xa0\x74\xe5\xab\x31\x43\xdb\x5b\xfc\xe0\xfd\x10\x8e"
+	"\x4b\x82\xd1\x20\xa9\x21\x08\x01\x1a\x72\x3c\x12\xa7\x87\xe6\xd7"
+	"\x88\x71\x9a\x10\xbd\xba\x5b\x26\x99\xc3\x27\x18\x6a\xf4\xe2\x3c"
+	"\x1a\x94\x68\x34\xb6\x15\x0b\xda\x25\x83\xe9\xca\x2a\xd4\x4c\xe8"
+	"\xdb\xbb\xc2\xdb\x04\xde\x8e\xf9\x2e\x8e\xfc\x14\x1f\xbe\xca\xa6"
+	"\x28\x7c\x59\x47\x4e\x6b\xc0\x5d\x99\xb2\x96\x4f\xa0\x90\xc3\xa2"
+	"\x23\x3b\xa1\x86\x51\x5b\xe7\xed\x1f\x61\x29\x70\xce\xe2\xd7\xaf"
+	"\xb8\x1b\xdd\x76\x21\x70\x48\x1c\xd0\x06\x91\x27\xd5\xb0\x5a\xa9"
+	"\x93\xb4\xea\x98\x8d\x8f\xdd\xc1\x86\xff\xb7\xdc\x90\xa6\xc0\x8f"
+	"\x4d\xf4\x35\xc9\x34\x02\x84\x92\x36\xc3\xfa\xb4\xd2\x7c\x70\x26"
+	"\xc1\xd4\xdc\xb2\x60\x26\x46\xde\xc9\x75\x1e\x76\x3d\xba\x37\xbd"
+	"\xf8\xff\x94\x06\xad\x9e\x53\x0e\xe5\xdb\x38\x2f\x41\x30\x01\xae"
+	"\xb0\x6a\x53\xed\x90\x27\xd8\x31\x17\x97\x27\xb0\x86\x5a\x89\x18"
+	"\xda\x3e\xdb\xeb\xcf\x9b\x14\xed\x44\xce\x6c\xba\xce\xd4\xbb\x1b"
+	"\xdb\x7f\x14\x47\xe6\xcc\x25\x4b\x33\x20\x51\x51\x2b\xd7\xaf\x42"
+	"\x6f\xb8\xf4\x01\x37\x8c\xd2\xbf\x59\x83\xca\x01\xc6\x4b\x92\xec"
+	"\xf0\x32\xea\x15\xd1\x72\x1d\x03\xf4\x82\xd7\xce\x6e\x74\xfe\xf6"
+	"\xd5\x5e\x70\x2f\x46\x98\x0c\x82\xb5\xa8\x40\x31\x90\x0b\x1c\x9e"
+	"\x59\xe7\xc9\x7f\xbe\xc7\xe8\xf3\x23\xa9\x7a\x7e\x36\xcc\x88\xbe"
+	"\x0f\x1d\x45\xb7\xff\x58\x5a\xc5\x4b\xd4\x07\xb2\x2b\x41\x54\xaa"
+	"\xcc\x8f\x6d\x7e\xbf\x48\xe1\xd8\x14\xcc\x5e\xd2\x0f\x80\x37\xe0"
+	"\xa7\x97\x15\xee\xf2\x9b\xe3\x28\x06\xa1\xd5\x8b\xb7\xc5\xda\x76"
+	"\xf5\x50\xaa\x3d\x8a\x1f\xbf\xf0\xeb\x19\xcc\xb1\xa3\x13\xd5\x5c"
+	"\xda\x56\xc9\xec\x2e\xf2\x96\x32\x38\x7f\xe8\xd7\x6e\x3c\x04\x68"
+	"\x04\x3e\x8f\x66\x3f\x48\x60\xee\x12\xbf\x2d\x5b\x0b\x74\x74\xd6"
+	"\xe6\x94\xf9\x1e\x6d\xbe\x11\x59\x74\xa3\x92\x6f\x12\xfe\xe5\xe4"
+	"\x38\x77\x7c\xb6\xa9\x32\xdf\x8c\xd8\xbe\xc4\xd0\x73\xb9\x31\xba"
+	"\x3b\xc8\x32\xb6\x8d\x9d\xd3\x00\x74\x1f\xa7\xbf\x8a\xfc\x47\xed"
+	"\x25\x76\xf6\x93\x6b\xa4\x24\x66\x3a\xab\x63\x9c\x5a\xe4\xf5\x68"
+	"\x34\x23\xb4\x74\x2b\xf1\xc9\x78\x23\x8f\x16\xcb\xe3\x9d\x65\x2d"
+	"\xe3\xfd\xb8\xbe\xfc\x84\x8a\xd9\x22\x22\x2e\x04\xa4\x03\x7c\x07"
+	"\x13\xeb\x57\xa8\x1a\x23\xf0\xc7\x34\x73\xfc\x64\x6c\xea\x30\x6b"
+	"\x4b\xcb\xc8\x86\x2f\x83\x85\xdd\xfa\x9d\x4b\x7f\xa2\xc0\x87\xe8"
+	"\x79\x68\x33\x03\xed\x5b\xdd\x3a\x06\x2b\x3c\xf5\xb3\xa2\x78\xa6"
+	"\x6d\x2a\x13\xf8\x3f\x44\xf8\x2d\xdf\x31\x0e\xe0\x74\xab\x6a\x36"
+	"\x45\x97\xe8\x99\xa0\x25\x5d\xc1\x64\xf3\x1c\xc5\x08\x46\x85\x1d"
+	"\xf9\xab\x48\x19\x5d\xed\x7e\xa1\xb1\xd5\x10\xbd\x7e\xe7\x4d\x73"
+	"\xfa\xf3\x6b\xc3\x1e\xcf\xa2\x68\x35\x90\x46\xf4\xeb\x87\x9f\x92"
+	"\x40\x09\x43\x8b\x48\x1c\x6c\xd7\x88\x9a\x00\x2e\xd5\xee\x38\x2b"
+	"\xc9\x19\x0d\xa6\xfc\x02\x6e\x47\x95\x58\xe4\x47\x56\x77\xe9\xaa"
+	"\x9e\x30\x50\xe2\x76\x56\x94\xdf\xc8\x1f\x56\xe8\x80\xb9\x6e\x71"
+	"\x60\xc9\x80\xdd\x98\xed\xd3\xdf\xff\xff\xff\xff\xff\xff\xff\xff",
+	},
+#endif /* CONFIG_CRYPTO_DH_GROUPS_RFC3526 */
 };
 
 /* 2 is used as a generator for all safe-prime groups. */
diff --git a/include/crypto/dh.h b/include/crypto/dh.h
index 2aee155f1e0b..e238380dee01 100644
--- a/include/crypto/dh.h
+++ b/include/crypto/dh.h
@@ -29,6 +29,13 @@ enum dh_group_id {
 	DH_GROUP_ID_FFDHE6144 = 4,
 	DH_GROUP_ID_FFDHE8192 = 5,
 #endif
+#ifdef CONFIG_CRYPTO_DH_GROUPS_RFC3526
+	DH_GROUP_ID_MODP2048 = 6,
+	DH_GROUP_ID_MODP3072 = 7,
+	DH_GROUP_ID_MODP4096 = 8,
+	DH_GROUP_ID_MODP6144 = 9,
+	DH_GROUP_ID_MODP8192 = 10,
+#endif
 };
 
 /**
-- 
2.26.2

