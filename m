Return-Path: <linux-crypto+bounces-24671-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIBTLSZGGGr5iAgAu9opvQ
	(envelope-from <linux-crypto+bounces-24671-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 28 May 2026 15:41:58 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 337505F2E4F
	for <lists+linux-crypto@lfdr.de>; Thu, 28 May 2026 15:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C6A31BA577
	for <lists+linux-crypto@lfdr.de>; Thu, 28 May 2026 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D823F6C26;
	Thu, 28 May 2026 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPmNREmI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E283F6C32
	for <linux-crypto@vger.kernel.org>; Thu, 28 May 2026 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975295; cv=none; b=Oj6vvwm/gzLt9jiYn0u4bkjFwIuGl5r1OFRggOMgYbq2YjODKVcsYOtoN82bokN1tGBKSvn9U+kte9iwEzM3L4qJprUo+n3/FN68qQ8ZvOQJymG6FfTCl+SdWZqZpgOIiL6wC0h2OUrcn/ehMKZ+xoaf89oF63ugNarWcchZwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975295; c=relaxed/simple;
	bh=D0k/9kMT/cL2pMsnIms6KyZ1W0wrvG21b+rTr48iBns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIctExKGFIZYmKX08P6p/eHvHkA/fY/5u4Ie0Qpo6UORQHhh1qrik23liHlofWnFZB7tqcpYb/wMLfpbbaLrh5yZvy4PtVVYVXz9nOvJL+85fDXlKlrVSDTR7CYovrvd1gSOLku9D+PkE18l/H2NPKzNMIpznjO1qCzQ7cHeoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPmNREmI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f8b60e485so5483338b3a.0
        for <linux-crypto@vger.kernel.org>; Thu, 28 May 2026 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975293; x=1780580093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yzn0YhLzTvt6pUfo05dJeo7r83ZFgX9EtU8J8f4Da+I=;
        b=BPmNREmIJR4XU8LQFxJunZZryQJ7DLcvzCwJ9h32wQtRvtmZefV1bDr7I2YJDbehDT
         xkhEbIzXVLCH8I0Wf+0r/YJw+pkx/lhMD1fM5ol7fzPHmCUeF9jdoC3zvSFFE7+IwxS5
         kDfC0G1YNl1rOUfFmKeMp+j03Z86mlCQyolnAPQYXCDMUL1tEl9wQ4LiOLZtlJQLdHxw
         BiPyf73ldvZdr7Jqzu4JuYKY4AWO1CMjcFASIYpISEpfzv0jk3rwvR5jITL4Z18Plf/O
         hnYLxaTtV697O/nhCt8+v7xVNZAINNYUXjNKgUG8c9gONwgT+LT6KFx+vl+bKnkI4mIB
         AgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975293; x=1780580093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yzn0YhLzTvt6pUfo05dJeo7r83ZFgX9EtU8J8f4Da+I=;
        b=Au/2wrGtMtbOxrV2tgXmSqa12DweSA72O8jL2tZr8DJCmtEWJbyHsANncDgLqHMirk
         wi1S/xbENWccg1KFMGv2RF7vo+PQspH4Z3uiqB2GEYFc+cWLNYNK7ulSjntal2wIoTAZ
         ro5qt2a3zA/0QSjMdyN5PqdHFou5eUAsjIRKLWHSlWb+m/vaYJBLCAbTBzbivuJSljbO
         ckJv1gnr7wtRMiYityggTUMzzHzB3erggCQdseup5jxycJmNECIjJdjN+k6P0e334ats
         Egb/Zf6uDhGMQHAP/fosWo4oBgbG3XWohqBjM+HLTj3a0F0A3u0G+Oofr2vHTW+kdUVw
         uJkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ufsGfaH+yZ8cEq8x8iAjeUmdtnOkrXOUo7GMb2n7x45fu3niRbumEVs9TvcJLhuEvzmMJghFVT1xudGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiFBwf8kQglMDQYDo3/ylnqIB67EvIPQH1AFAjDRkmNi+Y1a2
	ohlo0FvIpgRkTzA2mAW7O4mbyHNuclBsSi9vzrhknoap7MKHaCVlxSz0
X-Gm-Gg: Acq92OENVBwc0UvHLgEjSIE+Va/hg0f3OxYZFWMaHVgTPvnjnNPwskz6e5EW9vfMYeM
	ap9CpOiHlE6Ht42VilZkSKHncqmQgbIaL3pw2qESIQCgJP/YWZz1gn5AQfPuNfW58bjk7pT8v+a
	mRPbJ0kuK/uhMamZ4jMlmX92U81iDb8o/D2RYZFqqsgpQnrkacuYvrTRfFoys8bPISi3KSd07uU
	SHLwyqvnBKEx0ora6L28HJRHfIJdDweOZgAdqoBoYmSr1sLqhrORM10TbCOKdXLQxqGWpfQX7Pk
	xXPneEGEIrTlyfyjcs8Euk8gZ2NtrgxAk1LC8Sl0avh4EKKwBPYVmcvrOcN5E3ToTnZLnjoLTRg
	/WYAo1zFBwBz6fT3gpJL0MigfTxDmwnJ5Dec8pQ+iBIK0rNiaoPZAo3AcIst23tnvO9KuefULkn
	Yl7LJmkus7id89IbRbZ/YmrMW6Rp4+xlyBZ+0f5eFW/d9GOmENxPbv/DKt3Q56x2cTcCp5kBKkb
	xUb2VA2BFe7pIUlphE/LoKc
X-Received: by 2002:a05:6a00:3910:b0:82a:5ef0:210b with SMTP id d2e1a72fcca58-8415f15a77bmr25792188b3a.15.1779975293490;
        Thu, 28 May 2026 06:34:53 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.lan ([58.164.4.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6e82323sm5195429b3a.2.2026.05.28.06.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:34:52 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: airlied@gmail.com,
	andersson@kernel.org,
	bentiss@kernel.org,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	hansg@kernel.org,
	herbert@gondor.apana.org.au,
	jesszhan0024@gmail.com,
	jikos@kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luzmaximilian@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re: [PATCH v2 3/7] platform/surface: SAM: Add support for Surface Pro 12in
Date: Thu, 28 May 2026 23:33:47 +1000
Message-ID: <20260528133353.33312-1-harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6808166a-423c-c801-497a-ed95cccc8d0c@linux.intel.com>
References: <6808166a-423c-c801-497a-ed95cccc8d0c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,vger.kernel.org,chromium.org,lists.freedesktop.org,gondor.apana.org.au,linux.intel.com,linaro.org,ffwll.ch,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24671-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harrisonvanderbyl@gmail.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 337505F2E4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026, Ilpo Järvinen wrote:
> Could you please confirm this penstash is correct (sam vs kip)?
>
> Sashiko suggested it might be wrong but take it's report with a grain of
> salt, it's AI after all and sometimes seems to extrapolate about HW to a
> sibling HW without any real knowledge:

Sam is correct here, unlike the surface pro 11, 
The pen stash is on the reverse of the screen,
not on the detachable keyboard.

An image of the pen stash in use is available here:
https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/B04-Surface-Pro-12-inch-1Ed-Family-Rear?wid=1200&hei=900&qlt=90&bgc=F2F2F2F2&fmt=jpg

When using the above config,
pen stash events can be seen with evtest.

Thanks,
Harrison

