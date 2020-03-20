Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE3818D404
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2020 17:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCTQSM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Mar 2020 12:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgCTQSM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Mar 2020 12:18:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDC120739;
        Fri, 20 Mar 2020 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584721091;
        bh=VITXHo0sHdLtyj6pXdOB5yREmxZwclBqfrqMV2mzXOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dliZ1UGBNJQVcgyrav8UrCNriV6EBlp6Ok7U/K0GNtcj8e2JZogie6BZNPVEEaHuo
         oy5pWyifbExLOljoC0t0fLa8MklsTV3S59QQkbw129EKO+lWulDjMSZ0+stTffiUf9
         ePx0w9xGT9QsGE4iWuQlekl4a+RHICTBMuFp+w2w=
Date:   Fri, 20 Mar 2020 17:18:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Andrei Botila <andrei.botila@nxp.com>
Subject: Re: [PATCH v9 0/9] enable CAAM's HWRNG as default
Message-ID: <20200320161808.GB778529@kroah.com>
References: <20200319161233.8134-1-andrew.smirnov@gmail.com>
 <fab6192d-d35b-b26e-5bdc-b52b7d0347b7@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fab6192d-d35b-b26e-5bdc-b52b7d0347b7@nxp.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 20, 2020 at 06:13:18PM +0200, Horia Geantă wrote:
> On 3/19/2020 6:12 PM, Andrey Smirnov wrote:
> > Everyone:
> > 
> > This series is a continuation of original [discussion]. I don't know
> > if what's in the series is enough to use CAAMs HWRNG system wide, but
> > I am hoping that with enough iterations and feedback it will be.
> > 
> Andrey, thanks for the effort!
> 
> Herbert, Greg,
> 
> I hope it's ok to go with the fsl-mc bus dependency
> 	"bus: fsl-mc: add api to retrieve mc version"
> 	https://patchwork.kernel.org/patch/11447637/
> included in this series through cryptodev-2.6 tree.
> 
> It applies cleanly on latest linux-next (next-20200320),
> and it has been Acked-by Laurențiu (one of the fsl-mc bus maintainers).

No objection from me.

greg k-h
