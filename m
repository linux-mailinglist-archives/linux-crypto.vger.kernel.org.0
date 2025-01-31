Return-Path: <linux-crypto+bounces-9309-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E41AA23D3F
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jan 2025 12:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30203A9C55
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jan 2025 11:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D691C4A0A;
	Fri, 31 Jan 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Mx0r3qb1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35D1C175C
	for <linux-crypto@vger.kernel.org>; Fri, 31 Jan 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738323592; cv=none; b=lsQE9z9wKfF58a8DifQIBWgrDWt1BnNWhc166r4jB0JflQKJ+vnqCJtpWn+kRI2iKfn9SySRgJDL9VUEMHF/ddtB2NNuB7ah4CsHfCUSnGD+NUTz4ByupIZrWxK88qgJL0kELYgvUUYTxQ/8hFpoO7+z6zedtcHBTKaUb9PzUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738323592; c=relaxed/simple;
	bh=476EBTGgcI5xdYOaJ6LQa3tfmwSruyF9mYzvA+HovWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMigdtiMrjXOQtaQJVlURtY1Hzyqr0oKhLJ3zATCyP+gzViTUulSQyf7Qy4q1IlMPzQheU10UFi6u307rchoXm8GLPqZyt90KcGNhV0nOFUmVweTJpDK+unbpAMVH27GpnMDdT2gGgjYi90n2Mg0g6Mu/9JQfVfa+UBy0fPyM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Mx0r3qb1; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EA88B240101
	for <linux-crypto@vger.kernel.org>; Fri, 31 Jan 2025 12:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738323225; bh=476EBTGgcI5xdYOaJ6LQa3tfmwSruyF9mYzvA+HovWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=Mx0r3qb1A3UOSK2f5X2f8aZ/cla4BLWe91L6NYbDILMpq/Q2MMYQSatiaKTOK+wET
	 j7OgiaufoPmoH/+Snv9ZwjkcNdXlH/NMIaqvl1zBf2tED2piB0SqSTRwBf6x2OjfzR
	 /dFI1h+CGXmNQZh+TmIOXgNZuPk7SxlnDbT0VnojHMx/TWeOE4Q09ia2UYHvcIYMPJ
	 mz6v71TLSUzt1+7woDn4qz/AL6OuEDPhJTIIEhPEA6CGUqUToYtXKGHt6s5x0xzKTw
	 pHrCPKbTzrTKW3Fv4istIHCrFGWwa/sBMobWilniKzQXYhR2cfFyRi2ydyGf8uvOpu
	 JEXELxAsRJREw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ykv0g42F0z9rxF;
	Fri, 31 Jan 2025 12:33:39 +0100 (CET)
Date: Fri, 31 Jan 2025 11:33:39 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Frank Li <Frank.li@nxp.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 0/9] YAML conversion of several Freescale/PowerPC DT
 bindings
Message-ID: <Z5y1E6TUclqzV2Rp@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <Z5qr1VkKSlyBE/E4@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5qr1VkKSlyBE/E4@lizhi-Precision-Tower-5810>

On Wed, Jan 29, 2025 at 05:29:41PM -0500, Frank Li wrote:
> On Sun, Jan 26, 2025 at 07:58:55PM +0100, J. Neuschäfer wrote:
> > This is a spin-off of the series titled
> > "powerpc: MPC83xx cleanup and LANCOM NWAPP2 board".
> >
> > During the development of that series, it became clear that many
> > devicetree bindings for Freescale MPC8xxx platforms are still in the old
> > plain-text format, or don't exist at all, and in any case don't mention
> > all valid compatible strings.
> >
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> 
> Please cc imx@lists.linux.dev next time
> 
> Frank

Will do.

Best regards,
J. Neuschäfer

