Return-Path: <linux-crypto+bounces-25374-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0mziHPmzPGoGqwgAu9opvQ
	(envelope-from <linux-crypto+bounces-25374-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Jun 2026 06:52:09 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EEE6C2B19
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Jun 2026 06:52:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25374-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25374-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 498FD300EE91
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Jun 2026 04:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349262EC0A4;
	Thu, 25 Jun 2026 04:52:05 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from aesomtva16d.serverdata.net (aesomtva16d.serverdata.net [64.78.48.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906A1F5842
	for <linux-crypto@vger.kernel.org>; Thu, 25 Jun 2026 04:52:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782363125; cv=none; b=lMTuirJ73RUUUgxckdBh8XLIpRi/1iAQITXnKbPP9VXrtPiufWcCVNVuZYJH6QERv/biHK3bhFWZIMdykEa+NMnY0ze4yQ4z6xUag39RKXAYSMc/MqV993sH5huqaHyHsPexb0d1UKy+13vz7xcX/SCqIUpCdeq4H6/Qf6ht+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782363125; c=relaxed/simple;
	bh=egW8Y0SayjbMhnGY16ygLDMO9tc9OaQ20vDRFoJPC5Y=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=fK3YBc8KaJsevpEoTEX1mg0Pz5EZ2rivLzK0S8YDwrAfieX36uvWyP8qkRbLB02ebrZRo0WVAXAfGA78opxJla0tLKbrO1BsOvqBMtzuAjQ4luey5JzKj8OtBMpml3aVde+ytbv/3ArZpGVmNGCzKCfr3yMaE4SUfJ4/1olzXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesselsproknor.hostpilot.com; spf=pass smtp.mailfrom=wesselsproknor.hostpilot.com; arc=none smtp.client-ip=64.78.48.235
Received: from aesoc-va-1-3.serverpod.net (aesoc-va-1-3.serverpod.net [10.216.97.8])
	by aesomt-va-1-6.localdomain (Postfix) with ESMTP id B04D9C007D
	for <linux-crypto@vger.kernel.org>; Wed, 24 Jun 2026 21:42:59 -0700 (PDT)
Received: from MBX092-E1-VA-9.exch092.serverpod.net (unknown [10.217.23.182])
	by aesomt-va-1-2.localdomain (Postfix) with ESMTP id 7AA851200AA
	for <linux-crypto@vger.kernel.org>; Wed, 24 Jun 2026 21:42:59 -0700 (PDT)
Received: from [127.0.0.1] (173.225.107.183) by
 MBX092-E1-VA-9.exch092.serverpod.net (10.217.23.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 25 Jun 2026 00:42:51 -0400
From: <ZamaJuli@wesselsproknor.hostpilot.com>
To: <linux-crypto@vger.kernel.org>
Subject: Test Campaign 1782362571457-4323
Message-ID: 
 <744e554d-257b-fdc1-1267-a00f488449d1@wesselsproknor.hostpilot.com>
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Jun 2026 04:42:51 +0000
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: MBX092-E1-VA-2.exch092.serverpod.net (10.217.23.130) To
 MBX092-E1-VA-9.exch092.serverpod.net (10.217.23.182)
X-Source-Routing-Agent: True
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=H8PIfsUi c=1 sm=1 tr=0 ts=6a3cb1d3
	a=KmXYD0nqxBNGM8eoLlxHEg==:117 a=rCyhkYPouZquQ8S5x+Ivjg==:17
	a=soLeVifEdbMA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
	a=OQdMzU7Jr8vsYeHqMKcA:9 a=QEXdDO2ut3YA:10
Spam-Stopper-Id: b157bd03-2c85-4660-85d5-70a235f6913c
Spam-Stopper-v2: Yes
X-Envelope-Mail-From: ZamaJuli@wesselsproknor.hostpilot.com
X-Spam-Score: 0
X-Spam-Category: LEGIT
X-Spam-Reasons: {'verdict': 'clean',
 'spamcause': 'dmFkZTFJW34dbnQRdnALtsgsUi16YWkQpI7Yp59jJ6tRZMXQjXA8qz54n1m8DamuwCtUXidK9Et8aHA0rrXszzXbrfEq6pz/mLMpZcJPNMM+T2BbN/vUOBmAi+L8pvU5YNWIp9gA1BGhuBtbZAvX6tHSwJ6pMjp6n0jEcT+JNsnazps2ykcLRVYFznhXtBBlrBCD0fcxVEQfqhQAeyWXWvF0TXDSagrfCJO8lLL3kWFjMY6C4QidHpndf4j/YzYmYgghJPjHVPpXpvjpsRQtbbEEBJlC59pdvVmzNlmCmVP4iNgqiflOpK+FENWJ5QI7Kl5xMQ58e6cW4I8smQjz8MWYYOXRrM+/6tA0AnW736TstjzJNomfcaXRX+Y1n9x6Et+ZR3HPvYYFkFDnvq8gAVCbdBaSzM5OZ3qY2qsdxYgibZGEoAtwJRoTz67d1niVmPoadvMkkRYeIzJSdg8g7kq52Jgp/NAoywIz4aHLor+02Ff2dhT+vypc9p32tfH8orVj7PNk1U62ZBuJzXRRjv6uY5JWp9j8+2RA2plBxHU9KW3LYYZZ1NDp8iX1UuCulnQ4dzG7V8sGplVy6J6UMKUiIz+6+9Bxnp6zGpPUakv2PPrbO3VsHGCo7vh34kFJzWbOmyFg8dySJgfFVqIc2iBgOvhAyimggwdHduM3gqt4m3EHug',
 'elapsed': '9ms'}
X-AES-Category: LEGIT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ZamaJuli@wesselsproknor.hostpilot.com,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25374-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[hostpilot.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[ZamaJuli@wesselsproknor.hostpilot.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wesselsproknor.hostpilot.com:mid,wesselsproknor.hostpilot.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9EEE6C2B19

Please reply to this email.

