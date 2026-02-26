Return-Path: <linux-crypto+bounces-21214-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKOOCrJgoGmMiwQAu9opvQ
	(envelope-from <linux-crypto+bounces-21214-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 16:03:14 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C001A82E7
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 16:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2129930091DF
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828073D4111;
	Thu, 26 Feb 2026 14:46:14 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527563D5225;
	Thu, 26 Feb 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117174; cv=none; b=cDhr48nQReRQb0zmZYS4gS6NNrk/i8DuWhc4XouvwwnTsPmEWjiJEpFUEyFSvaciMFHfzyJkYAJME/GuI3jIRifEFey6F1QMsy0HCGMVhTPz3dVjHHm+/ogPwyD57Qng4bg7G4jEZqG3LeD46GZena1UIfAlC8s1QF7tIRtfD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117174; c=relaxed/simple;
	bh=dOx7L9FMXSNyyO9RDoQZeW4I5roMbAYAp6pktIjCurw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AeepFRFEuN/uQrTjXmw7l5z+OLsxDtni6WsuH0jJyyvtvALhPonWp/Rp7Mv00hna50Q6xNiMpeJAryEkgOzJmsdpH/lJvQw6IalgQ3KBx0OBD+0Su2ZdY8mRT+iUeIZo5zEL2KwAxPxLvjrIUeIs4bWvc6BIFBORmtrtnBLzmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1573C116C6;
	Thu, 26 Feb 2026 14:46:12 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/5] crypto: Drop stale usages in various help texts
Date: Thu, 26 Feb 2026 15:46:04 +0100
Message-ID: <cover.1772116160.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[glider.be];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21214-lists,linux-crypto=lfdr.de,renesas];
	RSPAMD_URIBL_FAIL(0.00)[linux-m68k.org:query timed out];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[geert.linux-m68k.org:query timed out];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,linux-crypto@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,glider.be:mid,linux-m68k.org:email]
X-Rspamd-Queue-Id: B5C001A82E7
X-Rspamd-Action: no action

	Hi all,

This patch series drops stale references to subsystems that are using
various crypto algoritms.  It was triggered by "make oldconfig" in
v7.0-rc1 showing new prompts about BLAKE2b, SHA-256, xxHash, and CRC32c
algorithms.  When querying these symbols, the corresponding help texts
incorrectly claim they are used by btrfs.

Notw that even if correct, there is no need for such references, as all
users should select the needed symbols anyway.

Geert Uytterhoeven (5):
  crypto: Drop stale CRYPTO_BLAKE2B usage
  crypto: Drop stale CRYPTO_SHA256 usage
  crypto: Drop stale CRYPTO_XXHASH usage
  crypto: Drop stale CRYPTO_CRC32C usage
  crypto: Drop stale CRYPTO_CRC32 usage

 crypto/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

