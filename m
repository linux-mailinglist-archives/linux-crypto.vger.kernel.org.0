Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A06E6371
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Apr 2023 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjDRMkh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 Apr 2023 08:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDRMkh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 Apr 2023 08:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E0713C15;
        Tue, 18 Apr 2023 05:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F65963307;
        Tue, 18 Apr 2023 12:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F811C433EF;
        Tue, 18 Apr 2023 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681821634;
        bh=VCwMMj2q4qUoHuODRqKDgoLte/T7yupow6Vv8LVr/gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4xh4h+eCEXXX9Ut5/f/cU8rxt/OtwjyHQ3nlpmLoC9P8b6BZ3lBDHL5QWU+gGJQX
         Mbo54vDNHCjUkL7y819xbfFN3VyQcKbqgSaBTTiou+f4x97NCz608EZTbcAoh0l5qU
         mQNzZPT3VsW8HcYnR1kxQgKaxT1OSQ74TE7F6tuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robbie Harwood <rharwood@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 45/91] verify_pefile: relax wrapper length check
Date:   Tue, 18 Apr 2023 14:21:49 +0200
Message-Id: <20230418120307.142778932@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418120305.520719816@linuxfoundation.org>
References: <20230418120305.520719816@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Robbie Harwood <rharwood@redhat.com>

[ Upstream commit 4fc5c74dde69a7eda172514aaeb5a7df3600adb3 ]

The PE Format Specification (section "The Attribute Certificate Table
(Image Only)") states that `dwLength` is to be rounded up to 8-byte
alignment when used for traversal.  Therefore, the field is not required
to be an 8-byte multiple in the first place.

Accordingly, pesign has not performed this alignment since version
0.110.  This causes kexec failure on pesign'd binaries with "PEFILE:
Signature wrapper len wrong".  Update the comment and relax the check.

Signed-off-by: Robbie Harwood <rharwood@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: Eric Biederman <ebiederm@xmission.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: keyrings@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: kexec@lists.infradead.org
Link: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#the-attribute-certificate-table-image-only
Link: https://github.com/rhboot/pesign
Link: https://lore.kernel.org/r/20230220171254.592347-2-rharwood@redhat.com/ # v2
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/asymmetric_keys/verify_pefile.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 7553ab18db898..fe1bb374239d7 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -135,11 +135,15 @@ static int pefile_strip_sig_wrapper(const void *pebuf,
 	pr_debug("sig wrapper = { %x, %x, %x }\n",
 		 wrapper.length, wrapper.revision, wrapper.cert_type);
 
-	/* Both pesign and sbsign round up the length of certificate table
-	 * (in optional header data directories) to 8 byte alignment.
+	/* sbsign rounds up the length of certificate table (in optional
+	 * header data directories) to 8 byte alignment.  However, the PE
+	 * specification states that while entries are 8-byte aligned, this is
+	 * not included in their length, and as a result, pesign has not
+	 * rounded up since 0.110.
 	 */
-	if (round_up(wrapper.length, 8) != ctx->sig_len) {
-		pr_debug("Signature wrapper len wrong\n");
+	if (wrapper.length > ctx->sig_len) {
+		pr_debug("Signature wrapper bigger than sig len (%x > %x)\n",
+			 ctx->sig_len, wrapper.length);
 		return -ELIBBAD;
 	}
 	if (wrapper.revision != WIN_CERT_REVISION_2_0) {
-- 
2.39.2



