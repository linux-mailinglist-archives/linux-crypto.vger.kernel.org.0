Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8DA1F7275
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jun 2020 05:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLD2s (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 11 Jun 2020 23:28:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38338 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgFLD2s (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 11 Jun 2020 23:28:48 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjaN0-00073c-Gz; Fri, 12 Jun 2020 13:28:43 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2020 13:28:42 +1000
Date:   Fri, 12 Jun 2020 13:28:42 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: qat - fix parameter check in aead encryption
Message-ID: <20200612032842.GA29394@gondor.apana.org.au>
References: <20200527221852.4942-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527221852.4942-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 27, 2020 at 11:18:52PM +0100, Giovanni Cabiddu wrote:
> Return -EINVAL if the input digest size and/or cipher
> length is zero or the cipher length is not multiple of a block.
> These additional parameter checks prevent an undefined device behaviour.

But a zero-length encryption is valid for AEAD.  If this triggers
an issue in the hardware, then you must fallback to software rather
than rejecting it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
