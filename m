Return-Path: <linux-crypto+bounces-4109-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A78C2574
	for <lists+linux-crypto@lfdr.de>; Fri, 10 May 2024 15:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E361283D21
	for <lists+linux-crypto@lfdr.de>; Fri, 10 May 2024 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2F129E7A;
	Fri, 10 May 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWWUx41V"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23209481C0
	for <linux-crypto@vger.kernel.org>; Fri, 10 May 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346880; cv=none; b=S0vw2XBjmkHCzBMSBWYOXqX0PTvICL3INOSFnGa/sk0fokyC8V8/HmrnGqUixSsHOgtTwkTS2ZS9kY3VxVg9RJL9e8nxsIyqfyf8Jt38fPrstkKzRgxpMKRZIYe5ZpAv+TUrbsMelQMbNeUju0UI40oW7YtRO0RgmdqGIr6JGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346880; c=relaxed/simple;
	bh=rbK9QlKtZEAygP+OrlU//xUS4kWM91LhPjAaLozYBRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uqdoRJGwVTCJSSYSrH3scLxpKRyWSIihvUFlNhXQ0WJHVlxByt1RF/Hig1xk/tqaYO7evTFYlFoeZkptcfrf4jiDDDt6mDt6+xXJqq1t2QI+FDUxXx5q0iNiBsSsXr34Us6Z0FX7IeqcnAMCQZGTs403E4hV2GojIJ+aLqVIwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWWUx41V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD558C113CC;
	Fri, 10 May 2024 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715346879;
	bh=rbK9QlKtZEAygP+OrlU//xUS4kWM91LhPjAaLozYBRY=;
	h=Date:From:To:Cc:Subject:From;
	b=QWWUx41VDmX8p6mja4ca3tbkvlq70+4JB9a0UF1drVpPy7Tjq/rmktivxGtObCk5A
	 hKKxM30O86V7JR0ZNMqJfu7B4P7qkmPgLwYEGBdrwJx3hE1RdLM6TR4kXHnhsQhTpd
	 Ci9/6dFZHdfVfh4YE1vWpUTUtt0QhuIaEetmLUAphZbGdsIwgi2NQzBc/efYWKYAJi
	 g4Z2MR9Ds2XTbXEU0K6RSZ+aVHVqdo2J2juQwrw6Y/5he2U3kCA/a1aon3hl5kXifj
	 Hs2MGg+70L6xWst+c2wnEkZNjc6ffsmRLQTfQQcbLbxG6PmmoSgSW4GvSnJjb7etWS
	 JUYQ+/cbN9YFQ==
Date: Fri, 10 May 2024 15:14:34 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Is akcipher ready for userspace?
Message-ID: <20240510151434.739fd5c5@dellmb>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Herbert,

back in 2019 you wrote that akcipher is still in a state of flux and
not ready to be exposed to userspace via AF_ALG [1].

Has this changed since then?

I am asking because I am implementing another driver [2] for a device
which allows for signing messages with an ECDSA private key securely
stored inside the device, and Greg asks again [3] for this to be
exposed to userspace via a dedicated kernel API, instead of
debugfs.

Back in 2019 when we needed this for the turris-mox-rwtm driver, I
implemented it via debugfs because akcipher was not ready.

Thanks.

Marek

[1] https://www.spinics.net/lists/linux-crypto/msg38388.html
[2] https://lore.kernel.org/soc/20240510101819.13551-1-kabel@kernel.org/T/
[3] https://lore.kernel.org/soc/2024051042-unbuckled-barometer-1099@gregkh/

