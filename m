Return-Path: <linux-crypto+bounces-779-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA9810882
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Dec 2023 04:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84B0B20FE8
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Dec 2023 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D2568B;
	Wed, 13 Dec 2023 03:01:16 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4B3AB;
	Tue, 12 Dec 2023 19:01:12 -0800 (PST)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4SqgBq5S1sz9yxwg;
	Wed, 13 Dec 2023 10:57:39 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 13 Dec
 2023 11:01:07 +0800
Date: Wed, 13 Dec 2023 11:01:06 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>
Subject: Re: [PATCH] crypto: tcrypt - add script tcrypt_speed_compare.py
Message-ID: <ZXkecmQGYT81R17C@fedora>
References: <202312101758+0800-wangjinchao@xfusion.com>
 <118d0b232f7daffc56db814f90dba7bad266c5ab.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <118d0b232f7daffc56db814f90dba7bad266c5ab.camel@linux.intel.com>
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

On Tue, Dec 12, 2023 at 01:56:56PM -0800, Tim Chen wrote:
> On Sun, 2023-12-10 at 18:19 +0800, WangJinchao wrote:
> > Create a script for comparing tcrypt speed test logs.
> > The script will systematically analyze differences item
> > by item and provide a summary (average).
> > This tool is useful for evaluating the stability of
> > cryptographic module algorithms and assisting with
> > performance optimization.
> 
> I have found that for such comparison, the stability is
> dependent on whether we allow the frequency to
> float or we pin the frequency.  So in the past when
> I use tcrypt, sometimes I have
> to pin the frequency of CPU for stable results.
> 
> One suggestion I have is for for you to also dump the
> frequency governor and P-state info so we know
> for the runs being compared, whether they are running
> with the same CPU frequency.
> 
> Tim 
> 
Thank you for the feedback. This information is valuable for stability testing
and performance optimization.

However, I am uncertain about how to dump P-state information, or I believe that
the script is unable to do so. The reasons are as follows:

1. The primary purpose of this script is to compare tcrypt logs, and it is
executed after the completion of the tcrypt tests. Consequently, it cannot
dump P-state information during tcrypt's runtime.

2. In virtualized environments, there is no available information in the
`/sys/devices/system/cpu/cpufreq` directory pertaining to P-state details.

Am I correct in my understanding?
I am considering documenting your suggestion in the script's comments.
What are your thoughts?
> 

