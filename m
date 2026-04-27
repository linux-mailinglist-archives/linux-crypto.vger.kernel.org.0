Return-Path: <linux-crypto+bounces-23444-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIGyFVTM72knGAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23444-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 22:51:32 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AC347A4B7
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 22:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8AF53034A21
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B42E3921E4;
	Mon, 27 Apr 2026 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW8fBl2p"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955038E129;
	Mon, 27 Apr 2026 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323037; cv=none; b=Vf26AFXaqtiP6Xq8/dCZ9wNl0sk0OOUu8LbHQtJFHGIdBav1gJI58paUBMMyhHKmKgscf1GfsXNGkexmddAtDBa7/xAXWGi5GvQ2DTIi9sLEegpV27Why18ArunMQ+g4PcaJwxqhYHUZ0LglSOs4A8ZoPhLEJgtGbI92BPZzYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323037; c=relaxed/simple;
	bh=I1l9YPP/ComIPE00fpuZz1ejIB5bhQV2RMeVzSfSA8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzSCuy+fEiI2IN4zCxgnDTuEjzBloLnXFDpN1nFLvq9g73eH98+nyQekem0U9oLHybr1A6TziefoZQKjKMGjZ96Kr/BahDIECmtjjmohUZ6UraPl7V/ZzbJouKppJDd/junsJdOo4uU/nDzW4eMOVxBMKgBBD+IeRSDOJ2HsvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW8fBl2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7CCC2BCB7;
	Mon, 27 Apr 2026 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323035;
	bh=I1l9YPP/ComIPE00fpuZz1ejIB5bhQV2RMeVzSfSA8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oW8fBl2pQCUd/SMtbsCIN9u/gRCSHrn4tkurhXz+veaW68ZIOIRt1H9eXktvNXJew
	 jDCO1x9y36KUTmMuJddOXGul1pj17MIUsv9rwdW6JOrRgCkdARyz5WF5eH93Gwjf8L
	 cMrzGVDqIDm141XzaUNp0V/tlzK9K+QkP6hmc/IpecIIcA6xrkzB+XaQsWFxOx6kE/
	 KgRzJfDt2OVlNOwlBdn7yHHgYv28UgfVBX7qCJDplogv/wE/0Q9NGhC5ifqXpX8K+P
	 R7fSyiW1LT0r2fGoe/g/yN/jGwAfnAVPS2yIvIdKli1ssGXh4pNpD2Sh9wua2D9NoI
	 L3Tm1A7c3nSdg==
From: Tycho Andersen <tycho@kernel.org>
To: Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kim Phillips <kim.phillips@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Tycho Andersen (AMD)" <tycho@kernel.org>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/4] crypto/ccp: Pass init_args to __sev_snp_init_locked()
Date: Mon, 27 Apr 2026 14:48:44 -0600
Message-ID: <20260427204847.112899-2-tycho@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427204847.112899-1-tycho@kernel.org>
References: <20260427204847.112899-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9AC347A4B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23444-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

Rather than splitting this off, pass the whole struct so that
__sev_snp_init_locked() will have access to any other structure members
that are added in the future.

No functional change intended.

Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index d1e9e0ac63b6..bf54a3fadb28 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1351,7 +1351,7 @@ static int snp_filter_reserved_mem_regions(struct resource *rs, void *arg)
 	return 0;
 }
 
-static int __sev_snp_init_locked(int *error, unsigned int max_snp_asid)
+static int __sev_snp_init_locked(struct sev_platform_init_args *args)
 {
 	struct sev_data_range_list *snp_range_list __free(kfree) = NULL;
 	struct psp_device *psp = psp_master;
@@ -1421,9 +1421,9 @@ static int __sev_snp_init_locked(int *error, unsigned int max_snp_asid)
 
 		memset(&data, 0, sizeof(data));
 
-		if (max_snp_asid) {
+		if (args->max_snp_asid) {
 			data.ciphertext_hiding_en = 1;
-			data.max_snp_asid = max_snp_asid;
+			data.max_snp_asid = args->max_snp_asid;
 		}
 
 		data.init_rmp = 1;
@@ -1458,20 +1458,20 @@ static int __sev_snp_init_locked(int *error, unsigned int max_snp_asid)
 	 */
 	wbinvd_on_all_cpus();
 
-	rc = __sev_do_cmd_locked(cmd, arg, error);
+	rc = __sev_do_cmd_locked(cmd, arg, &args->error);
 	if (rc) {
 		dev_err(sev->dev, "SEV-SNP: %s failed rc %d, error %#x\n",
 			cmd == SEV_CMD_SNP_INIT_EX ? "SNP_INIT_EX" : "SNP_INIT",
-			rc, *error);
+			rc, args->error);
 		return rc;
 	}
 
 	/* Prepare for first SNP guest launch after INIT. */
 	wbinvd_on_all_cpus();
-	rc = __sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, error);
+	rc = __sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, &args->error);
 	if (rc) {
 		dev_err(sev->dev, "SEV-SNP: SNP_DF_FLUSH failed rc %d, error %#x\n",
-			rc, *error);
+			rc, args->error);
 		return rc;
 	}
 
@@ -1651,7 +1651,7 @@ static int _sev_platform_init_locked(struct sev_platform_init_args *args)
 	if (sev->sev_plat_status.state == SEV_STATE_INIT)
 		return 0;
 
-	rc = __sev_snp_init_locked(&args->error, args->max_snp_asid);
+	rc = __sev_snp_init_locked(args);
 	if (rc && rc != -ENODEV)
 		return rc;
 
@@ -1732,9 +1732,10 @@ static int sev_move_to_init_state(struct sev_issue_cmd *argp, bool *shutdown_req
 
 static int snp_move_to_init_state(struct sev_issue_cmd *argp, bool *shutdown_required)
 {
-	int error, rc;
+	struct sev_platform_init_args args = {};
+	int rc;
 
-	rc = __sev_snp_init_locked(&error, 0);
+	rc = __sev_snp_init_locked(&args);
 	if (rc) {
 		argp->error = SEV_RET_INVALID_PLATFORM_STATE;
 		return rc;
-- 
2.53.0


