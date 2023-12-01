Return-Path: <linux-crypto+bounces-444-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF3800872
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 11:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930621C20BD9
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A369210EF
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 10:38:14 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24264B2;
	Fri,  1 Dec 2023 01:57:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r90GQ-005hRv-ME; Fri, 01 Dec 2023 17:56:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 17:56:59 +0800
Date: Fri, 1 Dec 2023 17:56:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, olivia@selenic.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hwrng: core - fix task hung in hwrng_fillfn
Message-ID: <ZWmt6wrbxN1W+cnv@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_97BC6EC36EF24C91A7E7C6DFD2C106688906@qq.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Edward Adam Davis <eadavis@qq.com> wrote:
>
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 420f155d251f..7323ddc958ce 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -225,17 +225,18 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
>                        goto out;
>                }
> 
> -               if (mutex_lock_interruptible(&reading_mutex)) {
> -                       err = -ERESTARTSYS;
> -                       goto out_put;
> -               }
>                if (!data_avail) {
> +                       if (mutex_lock_interruptible(&reading_mutex)) {
> +                               err = -ERESTARTSYS;
> +                               goto out_put;
> +                       }
>                        bytes_read = rng_get_data(rng, rng_buffer,
>                                rng_buffer_size(),
>                                !(filp->f_flags & O_NONBLOCK));
> +                       mutex_unlock(&reading_mutex);
>                        if (bytes_read < 0) {
>                                err = bytes_read;
> -                               goto out_unlock_reading;
> +                               goto out_put;
>                        }
>                        data_avail = bytes_read;
>                }

Does this change anything at all? Please explain why it was holding
this lock for 143 seconds in the first place.  If it's doing it in
rng_get_data, then your change has zero effect.

> @@ -501,7 +499,10 @@ static int hwrng_fillfn(void *unused)
>                rng = get_current_rng();
>                if (IS_ERR(rng) || !rng)
>                        break;
> -               mutex_lock(&reading_mutex);
> +               if (mutex_lock_interruptible(&reading_mutex)) {
> +                       put_rng(rng);
> +                       return -ERESTARTSYS;
> +               }

No this is just the symptom.  The real problem is why is the driver
spending 143 seconds in rng_get_data?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

