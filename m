Return-Path: <linux-crypto+bounces-23348-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SActM+rO6Wm9kgIAu9opvQ
	(envelope-from <linux-crypto+bounces-23348-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Apr 2026 09:48:58 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C5044E24C
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Apr 2026 09:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E062C30059A7
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Apr 2026 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5425F31079B;
	Thu, 23 Apr 2026 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKLExXM7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589C2F6596;
	Thu, 23 Apr 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930534; cv=none; b=GmQcXkV0LkEDDKYoPZnzj9gqi6db5Ud4vDol0M12NHu8+m8gPHtrTGyDJr9DfHqugXv9GPwLIgZj5a+EvY+aGVECQtr3sqJhiuRz49eS0BiJhSlEsDohIX3bV3ovvmtY4Ifi6VmwuSoWS0L/QRTloOl+WEItUP+llsCu7WIfsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930534; c=relaxed/simple;
	bh=pM1U/TIp/4xP17MhqKRuK/qJFURaPZPJN/CFUj8IK5o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b70u0vFV+WcZotwwSnwqMaMjjLVS6Z7ZdsF8kg79y1VpSbrolnFTHjCx5cLJSnErR4lvN20mCCUhRz/FexO034v4gmbnYnuT5nraED0Fcc+x2WNDT+7YlKD/r3BBXseU1oWhI7+/itHII6s+oR7lVr1spwD/qPPMIgvZp75NkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKLExXM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F32C2BCB7;
	Thu, 23 Apr 2026 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776930533;
	bh=pM1U/TIp/4xP17MhqKRuK/qJFURaPZPJN/CFUj8IK5o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AKLExXM7iSxDyqDIse04r9eC1GBKwHU4YoWVNKtqiWGVqkIzaaXQnwCyqU7yRclGN
	 i9rR53kpu5D3klCX2znOArrpKxCY2fB/2OyfAy16Yrj2crQGqKZG+84NC1M8NvRz2O
	 3EsdGgdLNPy001xKnMB7mHj629eeugYQ0OVf3EZWRtn06Hqq3CYDq5K61HQs2c5r/g
	 Jv+wVXgKAqExjt/gvt5VrVwPVy1t0ERpp+Mh866cSqSXgSPGRjaSmf6voIscMPfoPa
	 ud6vZfoLYCne1Iv0YgdHVba945ZcA4R1K+Z9fxcsosTf6xGxRpDfAECp3az+fZT2iO
	 e8WgT0EQEXmFg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6ABA8F40068;
	Thu, 23 Apr 2026 03:48:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 23 Apr 2026 03:48:52 -0400
X-ME-Sender: <xms:5M7paY8w2PdmadT7w5PBl02nDRu8zzOUvZj9MpahQRv34lbDpMWxjA>
    <xme:5M7pabj6D2SOaWz4b8yAa_E7HXtUPPvMN07t4DY-j0cz2STAFlY5NY29mnbPtEw4c
    gGhXPM9qtUBdGVM_SoRR-4DruOy7EdZsaolO5bjA7C9xTar8ls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiieehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhguuceu
    ihgvshhhvghuvhgvlhdfuceorghruggssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepvdeuheeitdevtdelkeduudetgffftdelteefteevjeevjeeiheefhfejieej
    fedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedthedttdejledq
    feefvdduieegudehqdgrrhgusgeppehkvghrnhgvlhdrohhrghesfihorhhkohhfrghrug
    drtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrrhhnug
    esrghrnhgusgdruggvpdhrtghpthhtoheprghruggsodhgihhtsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdho
    rhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtoheplhhinhhugidqtg
    hrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    rhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5M7pacahhlBqbOO8ewH291OJONmi1TX0zwKmSoDddIp0d5iRe0UcxQ>
    <xmx:5M7pacV6vyKc1i9kSvgBukeRCn1B7v6Oas5rJIOxz8iaQY1XgsiYVg>
    <xmx:5M7pabNz8Fjr2q4D7Bqb7b1u5mlgNqmhxdPssp0y0kyW-igoNe3tvQ>
    <xmx:5M7paWbL-do6E1aG6HVM2aB5VC1gw8KYxryveD-IhtdnAZO867_Drg>
    <xmx:5M7paa86KGgPWpQUqoGe5fjzbvMjnMyzpgIm1A9w8jh9T4xgd3KsiGGO>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B76C700069; Thu, 23 Apr 2026 03:48:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Apr 2026 09:48:31 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-raid@vger.kernel.org, "Russell King" <linux@armlinux.org.uk>,
 "Arnd Bergmann" <arnd@arndb.de>, "Eric Biggers" <ebiggers@kernel.org>
Message-Id: <ca8d1000-63ad-42a7-9990-cabcbecfe6b6@app.fastmail.com>
In-Reply-To: <20260423074614.GB31018@lst.de>
References: <20260422171655.3437334-10-ardb+git@google.com>
 <20260422171655.3437334-13-ardb+git@google.com>
 <20260423074614.GB31018@lst.de>
Subject: Re: [PATCH 3/8] xor/arm64: Use shared NEON intrinsics implementation from
 32-bit ARM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23348-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto,git];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 74C5044E24C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, 23 Apr 2026, at 09:46, Christoph Hellwig wrote:
>> +extern void __xor_eor3_2(unsigned long bytes, unsigned long * __restrict p1,
>> +		const unsigned long * __restrict p2);
>
> Does the alias magic prevent this from being in a header?


Yes, it emits the ELF symbol for the alias, and this is only permitted
in the compilation unit that defines the original.

> If so a comment
> would be nice, otherwise moving it to a header would be even better.

Ack.

