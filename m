Return-Path: <linux-crypto+bounces-25420-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ouXsBistPmqzAwkAu9opvQ
	(envelope-from <linux-crypto+bounces-25420-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 09:41:31 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9812F6CB056
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 09:41:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HZ95o8oJ;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25420-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25420-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCEB93026F06
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 07:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E59F3E3C76;
	Fri, 26 Jun 2026 07:41:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D33E2AB0
	for <linux-crypto@vger.kernel.org>; Fri, 26 Jun 2026 07:41:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459678; cv=none; b=qM8uGa1bEWFykpgjkTp3F5CK2z1oEe9Gr2SH3jvLMhGLnHhG1spzsp2YpLYMTetwBZk4bvyvfzPXep+lyFIaG9bYpxoIQYMozXHh3Cnl/TLpMgqMVLGHFY+MSj9OAbiAt8USQxOIqhhJpc9+rzVNdq3CQLQ5CtqDFOvPxvbiwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459678; c=relaxed/simple;
	bh=tB6BfSmbDpWx8DBiFm+S2h4b9xfHN2ANaz1OEIho8fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TghdD3T0xTQL77IE4ZZjaT7uPdM63bH+k/s9/2ESnYuTy4Qv069l6amHpSu+niRmYogs10ApgIttgH5ytZd8tQsbPGHkLEtm531pQDcA4kr+RHZioe2WpMYBFnvWOaSQ+KilLna0Y/MSuNxLFHU2S98qswYWl1xRDpnaMpJ6zUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ95o8oJ; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-462342ac290so603338f8f.2
        for <linux-crypto@vger.kernel.org>; Fri, 26 Jun 2026 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782459675; x=1783064475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k25eMOii6qvKTUwqK2ux2YYsD1dZ9vGEfhftC5yZWFo=;
        b=HZ95o8oJbST9PAJPOJEl9Z9evFOonWzoD6BtTidtv2hNkyEP2S4qfTviKp1NsI1bsB
         sxodC3B/Ro3Q0Jt2+e6NUy/grtj21sZ+0L8EffhY+qzcvnnQ/PjfhcWF17zEcJcKzFNI
         JiODiG4OTRp3oWhbn2w2enIoHnKhWdiWvE0CWQ548434DIISs2gHGDNXYT20JVMBGdwQ
         kdpEHg3uCTN1hGtcsMGh1qRA8+dtlUTI95CDIGwVeGd9SbFIcK2ZqI8ysz/nOwI6yZYo
         QD4ViHBIyLQS/GonOUs7xeGgvo04c8hhvKQF/8K+Kc93cI33X9KGmF+3WfFxMIV6SXXC
         6kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782459675; x=1783064475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k25eMOii6qvKTUwqK2ux2YYsD1dZ9vGEfhftC5yZWFo=;
        b=NJqSVdClhbT0jjwXRK0wVQF2yGIkrSjlyQlB9R700hOeoIKuzkX8t7edAsCHULU+c8
         FRYKDJpuBwWKxJZ5Ab4M2Y9lhYD2qHu6n8t+PqDQtVX5uu+iUO9Vb6MTSgXDTImj4rXg
         SnNlcqinRZM2bKHofwGgZcw2QxFAVhTC1TxB0HsemC2OO0/c/0amtk9oBRMCj+sADSfI
         rtDEtVWw/YM6vOv+pRKMdW0/5hePtAdS9523YKFpijlJnDCu3AoUvf+N8xVs9kQWB1Rt
         ht5MCmuX9vq6wQMrMfaD0s22arEYhFZqQEiuk5dbxRnrV3DI2hu+HeyXyW7MmTpKTZ+D
         c2vQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGUcGtDalT7qO4lt7333hdz9McolO6nxeRQO60Ehvg9TRxV1Y2qXvvvAtb82KuGGYA9aJYuj3LUkuGrWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzQF+MtocdZ8xZol/rVUAaKwGXD+e+9B2y5DesHet0Kn7MJwOd
	PIDw464lTsDEyjsIFQbSumW3ErlZKLgzHBSuT1CwXdPAaSqSnyfybb+/
X-Gm-Gg: AfdE7cnHAcQeRJq2itONUE7a1/dwu3OgwDp10eI2PQCU2Cub32QnVJ9Xmz6AfMAkbY/
	QhZTY2atThb9/FwEVjBLWYcAUT1OfoLqMf+QVpcpzOwIl7c9qm5JZ3oKVbrGR6ey5Ncu2uqAMA/
	7m+nplwNYdFCtDXBydVAHrjLxFMmNlsI3BzU/XHjqRjd9KfXF+6R9l/EyVzy4IpjbJgTivwpT76
	3Q1oHgNKYYXLgpB0rGVwkKbCxfmy0M1fx0wqcQbJGBzNdJg3KARmPTn3RTjno+78UIbyUOMkZmc
	IN3/kPPfZRx1ImutSd1pOMlYrWCyWhjVCX3z/tryjiJbsrGEHFZ/uKk78Nxe22Jp0+vSTnF3cFY
	IRHrkPLRa5u/+/zs9KDC8nhz2Cyy7Pg+YvZaUq4laRFwm601uJD8Z57wjJuRB1R6vNsSPzvaSC0
	dt4gYoWLsXqQl6rdLixWGgCZrDSExKDYtaW3uuQLeyxlM/XsKWIw==
X-Received: by 2002:a05:6000:24c2:b0:46d:654:d1f1 with SMTP id ffacd0b85a97d-46dc1a91830mr9870326f8f.21.1782459674983;
        Fri, 26 Jun 2026 00:41:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01c3bsm23853241f8f.10.2026.06.26.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 00:41:14 -0700 (PDT)
Date: Fri, 26 Jun 2026 08:41:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/8] um: Check for missing AVX and AVX-512 xstate bits
Message-ID: <20260626084113.42eae31c@pumpkin>
In-Reply-To: <20260626043731.319287-3-ebiggers@kernel.org>
References: <20260626043731.319287-1-ebiggers@kernel.org>
	<20260626043731.319287-3-ebiggers@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25420-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:x86@kernel.org,m:linux-um@lists.infradead.org,m:linux-raid@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pumpkin:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9812F6CB056

On Thu, 25 Jun 2026 21:37:25 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> If the CPU declares AVX or AVX-512 support, verify that all the
> corresponding xstate bits are also set.  If any are missing, warn and
> don't set the corresponding X86_FEATURE_* flags.
> 
> This eliminates the perceived need for UML-supporting AVX and AVX-512
> optimized code in the kernel (that is, lib/raid/ currently) to start
> checking the xstate bits in addition to X86_FEATURE_AVX*.
> 
...
>  static void __init parse_host_cpu_flags(char *line)
>  {
> +	u64 xcr0 = read_xcr0();
>  	int i;
> +
>  	for (i = 0; i < 32*NCAPINTS; i++) {
>  		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))

'line' comes from /proc/cpuinfo
Surely something would be terribly wrong if that included something the kernel
had disabled (or didn't support).

	David


> -			set_cpu_cap(&boot_cpu_data, i);
> +			validate_and_set_cpu_cap(i, xcr0);
>  	}
>  }
>  
>  static void __init parse_cache_line(char *line)
>  {


