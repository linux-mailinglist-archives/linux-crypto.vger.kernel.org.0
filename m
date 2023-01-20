Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA99675282
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Jan 2023 11:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjATKct (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Jan 2023 05:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjATKcs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Jan 2023 05:32:48 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2F38031;
        Fri, 20 Jan 2023 02:32:40 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pIohD-002BWH-CV; Fri, 20 Jan 2023 18:32:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Jan 2023 18:32:31 +0800
Date:   Fri, 20 Jan 2023 18:32:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] crypto: ccp - Failure on re-initialization due to
 duplicate sysfs filename
Message-ID: <Y8ptvzMeqoj+g6Gv@gondor.apana.org.au>
References: <20230109021502.682474-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109021502.682474-1-koba.ko@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 09, 2023 at 10:15:02AM +0800, Koba Ko wrote:
> From: Koba Ko <koba.taiwan@gmail.com>
> 
> The following warning appears during the CCP module re-initialization:
> 
> [  140.965403] sysfs: cannot create duplicate filename
> '/devices/pci0000:00/0000:00:07.1/0000:03:00.2/dma/dma0chan0'
> [  140.975736] CPU: 0 PID: 388 Comm: kworker/0:2 Kdump: loaded Not
> tainted 6.2.0-0.rc2.18.eln124.x86_64 #1
> [  140.985185] Hardware name: HPE ProLiant DL325 Gen10/ProLiant DL325
> Gen10, BIOS A41 07/17/2020
> [  140.993761] Workqueue: events work_for_cpu_fn
> [  140.998151] Call Trace:
> [  141.000613]  <TASK>
> [  141.002726]  dump_stack_lvl+0x33/0x46
> [  141.006415]  sysfs_warn_dup.cold+0x17/0x23
> [  141.010542]  sysfs_create_dir_ns+0xba/0xd0
> [  141.014670]  kobject_add_internal+0xba/0x260
> [  141.018970]  kobject_add+0x81/0xb0
> [  141.022395]  device_add+0xdc/0x7e0
> [  141.025822]  ? complete_all+0x20/0x90
> [  141.029510]  __dma_async_device_channel_register+0xc9/0x130
> [  141.035119]  dma_async_device_register+0x19e/0x3b0
> [  141.039943]  ccp_dmaengine_register+0x334/0x3f0 [ccp]
> [  141.045042]  ccp5_init+0x662/0x6a0 [ccp]
> [  141.049000]  ? devm_kmalloc+0x40/0xd0
> [  141.052688]  ccp_dev_init+0xbb/0xf0 [ccp]
> [  141.056732]  ? __pci_set_master+0x56/0xd0
> [  141.060768]  sp_init+0x70/0x90 [ccp]
> [  141.064377]  sp_pci_probe+0x186/0x1b0 [ccp]
> [  141.068596]  local_pci_probe+0x41/0x80
> [  141.072374]  work_for_cpu_fn+0x16/0x20
> [  141.076145]  process_one_work+0x1c8/0x380
> [  141.080181]  worker_thread+0x1ab/0x380
> [  141.083953]  ? __pfx_worker_thread+0x10/0x10
> [  141.088250]  kthread+0xda/0x100
> [  141.091413]  ? __pfx_kthread+0x10/0x10
> [  141.095185]  ret_from_fork+0x2c/0x50
> [  141.098788]  </TASK>
> [  141.100996] kobject_add_internal failed for dma0chan0 with -EEXIST,
> don't try to register things with the same name in the same directory.
> [  141.113703] ccp 0000:03:00.2: ccp initialization failed
> 
> The /dma/dma0chan0 sysfs file is not removed since dma_chan object
> has been released in ccp_dma_release() before releasing dma device.
> A correct procedure would be: release dma channels first => unregister
> dma device => release ccp dma object.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216888
> Fixes: 68dbe80f5b51 ("crypto: ccp - Release dma channels before dmaengine unrgister")
> Tested-by: Vladis Dronov <vdronov@redhat.com>
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>  drivers/crypto/ccp/ccp-dmaengine.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
