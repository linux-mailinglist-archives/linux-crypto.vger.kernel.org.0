Return-Path: <linux-crypto+bounces-2782-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68491881384
	for <lists+linux-crypto@lfdr.de>; Wed, 20 Mar 2024 15:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BF31C2137C
	for <lists+linux-crypto@lfdr.de>; Wed, 20 Mar 2024 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D39D47F7F;
	Wed, 20 Mar 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jYMzfDk"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77A47A63;
	Wed, 20 Mar 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945702; cv=none; b=QpIhGeJbuFF3nupcWKi7kG/dWg+6ZSKKlXflx0VdOOKvKsvDvm+INnIQuDqVkCWrdGef0QXCkknVN1UbXTwhCkmYlMDFmd8XnXmyPH9fKkKEsm9jAXTa/R82FHj+FBBC4fADzkZe4X5JUE1BUYHaU31aijk7k0iZfvqvCrRmaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945702; c=relaxed/simple;
	bh=c+qydTcdDiWEhegPfInrY2m5GA2Px0fsvspdRaHkQyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVOqOA4ljtfagn0pPlXeXb2izNaAlsHj6NANJxr47sFIasHgvorYspLkwmeuCj8YAtKQaPrpgqWNB4Yk9btl5sUws3fqS2iJO3U8m53t3EWFwwlVPDzZlpTIzxbdRJsHN1hO3ty8e81YV6YakjvzTb9vY7jBkcy638fkFF3cqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jYMzfDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBA5C433F1;
	Wed, 20 Mar 2024 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710945701;
	bh=c+qydTcdDiWEhegPfInrY2m5GA2Px0fsvspdRaHkQyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2jYMzfDkRc+gf59Adey/UTyHmlLE5SqFEUZlkADmUHgxfFE7gZ6vwcgH+2Jae8gzm
	 6AFT2ZqeLKyRk4bH8BcwKkwlcusb3U2ssdH2vNGLwpz31eebasj5DkWDPXGS1BrP9q
	 STOtmjnMrZn5UP1ibhRt0CC4jAy42Xe+o+uVJqAE=
Date: Wed, 20 Mar 2024 10:41:40 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Stefan Berger <stefanb@linux.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, 
	bbhushan2@marvell.com
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
Message-ID: <20240320-quirky-truthful-manul-da6eb9@lemur>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
 <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org>
 <Zfp20bLB0onXo7FV@wunner.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zfp20bLB0onXo7FV@wunner.de>

On Wed, Mar 20, 2024 at 06:40:33AM +0100, Lukas Wunner wrote:
> If Herbert applies patches with "b4 am --apply-cover-trailers" or
> "b4 shazam --apply-cover-trailers" (I don't know if he does),
> it is completely irrelevant whether Stefan strips my Tested-by from
> individual patches:  It will automatically be re-added when the
> series gets applied.

Applying trailers sent to the cover letter is now the default behaviour in
0.13, so this flag is no longer required (it does nothing).

-K

