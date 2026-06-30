Return-Path: <linux-crypto+bounces-25489-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jCYdKWZRQ2qTWwoAu9opvQ
	(envelope-from <linux-crypto+bounces-25489-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jun 2026 07:17:26 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C3C6E0747
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jun 2026 07:17:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=p37JNkZP;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25489-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25489-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACE8E300B5AD
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jun 2026 05:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D363ACA61;
	Tue, 30 Jun 2026 05:17:24 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192C369D6A
	for <linux-crypto@vger.kernel.org>; Tue, 30 Jun 2026 05:17:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796644; cv=pass; b=X+NVTPsA7wS3PnqsTuc9DQat1GqWv12yeilVDWFOUbFitnKIit08iBIrLPU+Vj5O9fF/OLEAi1yynvk8hJFX9z+kDfGhDLRi6V7J4d8YW92w/0f9zBo1GGdFTXMqGEZ9tHlEzkaA+7Pwv0IyEEfT3WOZkND7ZmFEK/dLybMNl9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796644; c=relaxed/simple;
	bh=MhekwebJ2smltngIeM8TmueA3GHWqgPQcamLi0Ts8+k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I6Sshof7JbYa0M6wXn1XYeEgQSvC4v48Omv8zd2B6eLcGh8hNBv6tm/kBkJjAlfaHBByYg1ZqzN4Ra42FS1/oUWvw8/6evJ/lP0m/aBoUKo6zm66HKQXiGqLk/1SpdMa/cp1U5yUy5ziBeAPVavn24Puz+6oi/5ukgICtz+W0fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p37JNkZP; arc=pass smtp.client-ip=209.85.217.47
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7389cff36bdso681752137.1
        for <linux-crypto@vger.kernel.org>; Mon, 29 Jun 2026 22:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782796642; cv=none;
        d=google.com; s=arc-20260327;
        b=oKbaR24B3XF6gg3Oti/Da0mN1EEC7qfiJSiuqsWiaUG6sIwIVdzGmlcp+9cbZKcZq8
         1JSUObCEiExR3mJEWIeIYTyehefuixGfJHzfDZ3NQUzLyfxj7GvCXfbA1UjscvPrcORu
         7ttzZ4KIT21CP1zqKH2JRBYDY8x7SswpsQ8ph/LyMPXsuD28ncTJ6j/T2IBw8YeUxaV+
         Oq/v9klO/F5y/Zt7l1U7F+ba94IDlxJf0UDkGzFzL1hGG72F02wGuE6dyptJVDZtGBOw
         hnA9l5EeX8DwPvnw6qrelTsuoU54zELNusWqUCqNYtfiwlyWoksJyCaUdKff3CQXiahK
         49kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MhekwebJ2smltngIeM8TmueA3GHWqgPQcamLi0Ts8+k=;
        fh=IdhgEVD0yJCkxMqCBNMoCM97ia6noBsT6jPibcKigF0=;
        b=SDbCROFeNy936zufR1dQZTaSBdB1VUb7X/f8D+y/Zy0fAdbVaJrsuQ6wpppI+btaJo
         PUW37JDEwXEOaJDCn5TyrR/9WgnuN8Rfxps6p7qc1JCk1wCyvG7ZTdBN4K9HXdoHaXLr
         oJGu7AKO2vD+TQswo2pN0Q3d9sJVsTFLfjYiqL5F9yge3zC20Jk95KR0xmW3jDO6kFl/
         77tn46jJWcM7kqI8dJhqinhR0lLe/S3a3hZW2u9mVyFfvRSOWYfqraU2VfsgS2uiUmqH
         gATnKw2Mq7g391p0dLAEXKMIl+oBcbSDoJKcv8nDrdvhJGVA7W3aK/xjFQsejshSkxka
         0HYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782796642; x=1783401442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MhekwebJ2smltngIeM8TmueA3GHWqgPQcamLi0Ts8+k=;
        b=p37JNkZPZ5vNd7cQUnnWTItxKXvP8VnqH3NY2LnXOOvYWQNsOKVi/KWdLYdgrgB+6p
         1wnH8uwwwy6ILtpsSDjUiYVMN6NOuRIZF8lp6JKUJnHxDjOJwDQSiM1q4OGfCb8PI7Y9
         PnsSDDofVdm530g+yxtlaZjLwbmCxEPc0Fi5zaVv2hp95HI5jESSWG2uLf3LV54XMNVQ
         J4K3RRPSQnBGdnKgoLBhhNF/Y6Dh2w5W4spoyqoK+Z+gIVQU2i9fIm1Oy3pA2nXBr1Sa
         gZEFwK058R2II3oAAe4kaYsZVbvXW7FDe9F5aUiN4neKSqgCwKRBgAeV3r+AQWtoPxiN
         FWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782796642; x=1783401442;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhekwebJ2smltngIeM8TmueA3GHWqgPQcamLi0Ts8+k=;
        b=Wu+OVBcItpOZTfZcKt6pPu3WUhH9sZdQs/72EsprFEgw1u6MhcDAVPTvXvDm22xsMG
         JPi1RIVzZ+hoPuhKwLyzuJaUvTG67X2Ml2h0BmK5PwxyIbQFtvpwuHl2rZ36s5HMoD+6
         DKiHPcEfrroWooz0okG4XGfhibbOBq9qWLJRLYaGjQPR6ehn5gtUcB6iGLFaViyAH8Oy
         bH1tGooybZata5ot49aQ5WmVhUXQBbkRbngF0czjydmrpmeBDvjL+JSl4WVJ7V9DV0nd
         xDPARL3k6Vpe+hsUcuHnMKC+N22AwGpo/1+KaNuTNRKpWdy/gFSiRe4OZYefXdQqq7L5
         1M7A==
X-Forwarded-Encrypted: i=1; AHgh+RqLfOziPP87nHdcI00NX+aOLPEiWsk4Wr/mAnBxDJcuAk6UvzxF6qBO30sjds9q6Lj/Jy9D/cNQGMR2cyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpCVetDfDpXe9rEAPsd3MBenlw9v6VIzpRElzZQa2xRquh1xp
	Va6MdIuH3tUztFPulJtMkwncF3XTCGbqsTilsg3A3i+aXAA4BpDL325rBVdIPZ5lxQF2PL5WXA2
	3L40cbXtsnrpFGtIdNaoNTiQZvXhJZJM=
X-Gm-Gg: AfdE7clpGuvKcpjLruqbvgwWpNoRm3e8cOeQh39Nf32b/dRcJ7cqi3shl4lsG2jWGvp
	UU3aPOANwAv6UfbS91WgIZ1Z6seIZMtG4w5rA2h391ry2+dqhUKDa9iLAZwJ7bxfpcOHabJyKWt
	dlSv8jNt5Y+O3N5C5hBegfD2d28G8eW0WyK8znjQjpKSxVDd8+WfI6xGPXTkSnv92rfkdkR7/4C
	cPzXyk7q0VQvzZf5wQ6U7V7i6nEfyG6QQ/UVn6kUFOaevPg0Xe96dOXzd3MOrmLce3Qbmx1xM9w
	yeIIKcRwofcpHSntMxra+ArKCtzgROcFUyM3JUbVMLerHOp1qXJu3M34/tk8
X-Received: by 2002:a05:6102:f89:b0:6cf:37fe:2cb with SMTP id
 ada2fe7eead31-73a39129e92mr1257123137.27.1782796642265; Mon, 29 Jun 2026
 22:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arisa Snowbell <arisa.snowbell@gmail.com>
Date: Tue, 30 Jun 2026 07:17:11 +0200
X-Gm-Features: AVVi8Ce145OqFMujq5GvBsemC4oMYPOpWmBr-CPyqleepoTtg-l-4QQnIWrbjvk
Message-ID: <CABpa4MCO4OoZ+j8swDYUeCM34WCh4bKcd=ZjG=K0OZoTkB8aCQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] virtio-crypto: support ECDSA algorithm
To: herbert@gondor.apana.org.au
Cc: berrange@redhat.com, davem@davemloft.net, dhowells@redhat.com, 
	helei.sig11@bytedance.com, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, pizhenwei@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25489-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:berrange@redhat.com,m:davem@davemloft.net,m:dhowells@redhat.com,m:helei.sig11@bytedance.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:pizhenwei@bytedance.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arisasnowbell@gmail.com,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arisasnowbell@gmail.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43C3C6E0747

Hello,

I am currently setting up EAP-TLS authentication using iwd. As iwd
leverages the Linux kernel keyring (keyctl) for private key
management, I am running into an issue where secp384r1 keys fail to
load. Consequently, I am unable to connect to our enterprise Wi-Fi
network.

Given that ecdsa_generic is now upstreamed/available in the kernel, it
might be the right time to revive the previous patch addressing this
limitation.

Any guidance or updates on revisiting this patch would be greatly appreciated.

Best regards,

Arisa

