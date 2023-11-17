Return-Path: <linux-crypto+bounces-151-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB0E7EF0DA
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 11:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3202E1F289FD
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 10:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DB199BE
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A34BC;
	Fri, 17 Nov 2023 02:36:39 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3wD0-000cJb-BZ; Fri, 17 Nov 2023 18:36:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 18:36:30 +0800
Date: Fri, 17 Nov 2023 18:36:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Weili Qian <qianweili@huawei.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, wangzhou1@hisilicon.com,
	davem@davemloft.net, xuzaibo@huawei.com, tanshukun1@huawei.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon - Add check for pci_find_ext_capability
Message-ID: <ZVdCLjo7GOQN54sx@gondor.apana.org.au>
References: <20231109021308.1859881-1-nichen@iscas.ac.cn>
 <6eeced40-7951-ca0d-1bcd-62e1d329ca96@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eeced40-7951-ca0d-1bcd-62e1d329ca96@huawei.com>

On Fri, Nov 17, 2023 at 10:07:00AM +0800, Weili Qian wrote:
>
> Thanks for your patch. The function qm_set_vf_mse() is called only after SRIOV
> is enabled, so function pci_find_ext_capability() does not return 0. This check
> makes no sense.

Perhaps we could add a comment instead?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

