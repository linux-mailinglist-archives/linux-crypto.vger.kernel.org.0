Return-Path: <linux-crypto+bounces-23311-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGk/NBUE6Gl2EQIAu9opvQ
	(envelope-from <linux-crypto+bounces-23311-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2026 01:11:17 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6842F44070B
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2026 01:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 601203065A74
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 23:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC3387373;
	Tue, 21 Apr 2026 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN3oK5G7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E13033E8;
	Tue, 21 Apr 2026 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813065; cv=none; b=uW3rcYT+//tDYVTwv+TG52l0MUHNRqeUin2RFHQn9qaWr4mGqNSwm0VCbXyFPdgZGShbK/YBKJvfdKqPXR3hJIqoe9I8lH0M0Wa+bODPSMN8ivmrHrQ6Lvn98F1YAM6Y2Gr0iRMfZ+o7VhoD3YdInCy3SbH6JhoNLoZHhDi3rnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813065; c=relaxed/simple;
	bh=s8w6aRrTGIVZcZnott7hhbbp4pjV3SKo8FhHdlUnzbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MA3VCjItaxowliCCvjp6xXDWAuBtMizG24J48ky6OdknTKNMbuaSsotLBRssLQx1BksPNuB+ga//kG5KsylRFbxeYAZxV8g6do4B4OT4tMimKVUTim3YVcbg9UBOvhCYpFoCSAc22iDRt+uME/DTANEIWgFz6rU3tvdE4gQvy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN3oK5G7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792ABC2BCB0;
	Tue, 21 Apr 2026 23:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776813064;
	bh=s8w6aRrTGIVZcZnott7hhbbp4pjV3SKo8FhHdlUnzbk=;
	h=From:To:Cc:Subject:Date:From;
	b=NN3oK5G7Dl4QBpQKVqrBqlVI53huLV0mOqha+6VR6HyEUqCKBuEMpEjRsL4Y0zQVW
	 cgnzUWMmXGACWzp8BzEPGQ8aK2/Rap9JZ3/Z4fbivOaZbaHtoJ7/Yn+CqYS2zPrkaV
	 zE5x2TvfDZzvodMVlgBA3yiNOT+EQsET0jiD/c19OxYo0tEyA7Dz1unaLmTGTKYm8q
	 MTRKG/8oEEqpNYkm2v2MOnXHs8AnGhvrqgNRbobalHXlMwwKRICs2jR8rKDI0XGyVl
	 2+cAtCahpdEJFe5xoIpQGdfMIzmnQ6eC4RhS86qUAsswMqDIkOChyR43Vqpe0Np3A6
	 a5J1blk3rpCxQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/2] Bluetooth: Use AES-CMAC library API
Date: Tue, 21 Apr 2026 16:09:15 -0700
Message-ID: <20260421230917.7057-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-23311-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6842F44070B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series removes unnecessary kconfig selections from CONFIG_BT, then
converts net/bluetooth/smp.c to use the AES-CMAC library API (which was
introduced in 7.1) instead of the crypto_shash API.  This makes the code
simpler and more efficient.

This series is intended to be taken through the bluetooth tree and can
be applied for either 7.1 or 7.2, depending on maintainer preference.

These patches were originally sent as
https://lore.kernel.org/r/20260404200645.28902-1-ebiggers@kernel.org and
https://lore.kernel.org/r/20260218213501.136844-14-ebiggers@kernel.org/

Eric Biggers (2):
  Bluetooth: Remove unneeded crypto kconfig selections
  Bluetooth: SMP: Use AES-CMAC library API

 net/bluetooth/Kconfig |   6 +-
 net/bluetooth/smp.c   | 180 +++++++++++++++---------------------------
 2 files changed, 65 insertions(+), 121 deletions(-)


base-commit: d46dd0d88341e45f8e0226fdef5462f5270898fc
-- 
2.53.0


