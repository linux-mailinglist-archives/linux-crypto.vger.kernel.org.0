Return-Path: <linux-crypto+bounces-22147-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A+rK8EPvWlf6QIAu9opvQ
	(envelope-from <linux-crypto+bounces-22147-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2026 10:13:37 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 228A22D7D1A
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2026 10:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 730B030E18BF
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2026 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3686437EFF3;
	Fri, 20 Mar 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="E10iuiHj"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D87345CC0
	for <linux-crypto@vger.kernel.org>; Fri, 20 Mar 2026 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997877; cv=none; b=ENNT9ec2blfqsi4nmHNnhAvFZwQUQZZyXPZ9+dM7134yqqUkpGmy377lcIuazhSmvEqa0TLOqLyY1vu2O6Uo4GC1/+2BTv+81XeSV57ntopxBLl8MPizUNgZ2i2E/XUodMjXhrpJ/GpK/oSrJ6a6pI3BMJmPdqY4hL772YFG+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997877; c=relaxed/simple;
	bh=osPuVGUm/UzZnnch36LBSX5ZBydiJ3syEDW7/rP0ehg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2jJLqlx340teMNgkdYpK2lIPHEU/KLiQ4Bjlh3cq8SkzdaWc+5MhTC5Xdi+5OwvAAUUSTIRF9EL8TtVXHoTYu/ETEOOlCA9kCiPjZdzy6dOXuQb2u9KKhYozaj4cUPbE7/klXdxutxY3zT9wOgbRaeDSrUI61BMF+9stw6Ymz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=E10iuiHj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso3002155e9.1
        for <linux-crypto@vger.kernel.org>; Fri, 20 Mar 2026 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773997870; x=1774602670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnvpWrvuYkXuiKq1OQLuzrMxSlnrYn7ohrRGMt5HMQU=;
        b=E10iuiHjIszaS2WGaFn7yUugVwA2m8d+5Ic7sUjvPMClbXlGxOb5+03kYWeCY4DLIJ
         wAnQY/Di5k6ghnD9rzz3LNUz0L1CAgzzvi/T9XeIKvKabO5+jj/EFVcHM/43k4nsVHu8
         llxcjCC8K5XarROMaaT33EGRCRTmFvpGew95d971JOdI3aGGmrhG0zrMf/tzFTtvlRxR
         oeexdmTCS6W+PtY99Ab8i80vpd82rzJlHKZvAiJmsq82H05lnGSFSR0EA3rizJE9E+lv
         SKzmMLmY+v0cYR4aAfVd03IspAzfYyruSQe+lYjwYfwzSH/JHmFpA1JlO2BZkrplbuSB
         eZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773997870; x=1774602670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnvpWrvuYkXuiKq1OQLuzrMxSlnrYn7ohrRGMt5HMQU=;
        b=eRIDtTCwsalawFQyhQEfBu5EcWi7xmF1FznxTTpbHsj6IgK2MKQFLW7kNyy9naWPXA
         iZwvoVfe8TisQ8EOL975b+rWvyk19x2bJQ2PV58usvd70dNnYmcH9/VBedarlcJnriEM
         alvTmBFp+3G/EKB2PE/G+qrFljV3Kt4XJhSHmzq5qzRGWKZwfpt1+tspOkFWaYrkY5lC
         4s9L6PE1lsvvac/yZusH6Y6BXxoMAkVEqkldPC9mEZTth9vifbZwtIh/Um9ERM6bu6uK
         QlPPdqO10SThNDwFccaFfp8iD0rkZFoCf9U6+tgzqKHM/8LgT4Bv+SHqSKbhH0pJfMFn
         vyGw==
X-Forwarded-Encrypted: i=1; AJvYcCVGoIH3tnGdw4ueb/Nz5hL7o6jylj4CfWJeVNMI84PzsezSPVuUrCSoENYoHc6JQb5Lo/PcRGRFNzxDZEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xf/jbVOGhd+lwMAbVp0mKBe4ZMKOKCEhjq8un7Sc/ZpDcBz5
	dd+CqJ2hlX+b+XT8LsOOSP2f0Ws1Td0c3kwF4KHGnjvEOuowELCPkC6Tx3c6qm0k92k=
X-Gm-Gg: ATEYQzz3snqZiuGypSPokLPz+p7StsQpMnUOoCJP50zB2KphCOegAqYthdrtT+t+Swe
	wDJL/fuBx4rTau3B/6cFtWCrfEw/eGXzrJOuAh6+BYGWQQQVKky2Fd5leHTLOvjtJ3Vjc7XiCJo
	31XBUinoVUM6fhE6SIdwfqACzjyvLuY3z9Uqq4/kC147+ZITrh/wfkAjK/kV8CmSyUYvZDmW1zX
	jQF18p6opVeFtgkPHCSzJNqxMC+wIjGDZoFfadU2YrArD+Tcc52l2EDLolZmjqIGVtwBJLlCj9K
	a9Z/GMZ1/fOZZruoTVVq8R0rvjJVjCQ2AqBmu8S8MhBFBXGMjtMPHS/TAmpY2Ry7D+d2AQMFL7J
	g3UEXojT+/P9tfYS4tG9lSgY3UhLQqb36XxQzi2EbhDbLDVGQtiA1SmBSbaaDZ1VsYZp0X2+u7V
	XrOQIIuiW2GndulK0BAK/IE1Aegjznh3c=
X-Received: by 2002:a05:600c:1f86:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-486febbc653mr33123025e9.6.1773997870011;
        Fri, 20 Mar 2026 02:11:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff118bb4sm18208155e9.2.2026.03.20.02.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:11:09 -0700 (PDT)
Message-ID: <1f684500-6c06-4abd-984a-4cf889acfcc2@tuxon.dev>
Date: Fri, 20 Mar 2026 11:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Add support for Microchip LAN969x
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, olivia@selenic.com,
 herbert@gondor.apana.org.au, radu_nicolae.pirea@upb.ro,
 richard.genoud@bootlin.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, horatiu.vultur@microchip.com,
 Ryan.Wanner@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr
References: <20260302112153.464422-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260302112153.464422-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22147-lists,linux-crypto=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 228A22D7D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/2/26 13:20, Robert Marko wrote:
> Robert Marko (6):
>    arm64: dts: microchip: add LAN969x clock header file
>    arm64: dts: microchip: add LAN969x support
>    dt-bindings: arm: AT91: document EV23X71A board
>    arm64: dts: microchip: add EV23X71A board

Applied to microchip-dt64, thanks!

