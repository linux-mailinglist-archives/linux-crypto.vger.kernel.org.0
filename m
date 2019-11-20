Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BD8103B79
	for <lists+linux-crypto@lfdr.de>; Wed, 20 Nov 2019 14:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfKTNdR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 20 Nov 2019 08:33:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727442AbfKTNdR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 20 Nov 2019 08:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574256795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZkd15m2R5x+t+kR/h/vIqlMxIKiIzHQkfDYH6NwhZ0=;
        b=g7qNK0mXor2LPbhV3pcHP3q88xKLDhwkuCY6+3PyTf5cLrXiGKNV052dGMtV/i+OvRpn+e
        LIFXjJ4L01p+owbWtsMMNAJAXO1hg3GdK7Ta3Yx3OpJ691GfR9r6xrQcI/iF1Fq0D6IaiD
        zIsH2xluP6hvbjQqyu+93Dj4lYOwF+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-jkXhu30zOsioLGVu8LUIDw-1; Wed, 20 Nov 2019 08:33:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4DFC1804977;
        Wed, 20 Nov 2019 13:33:09 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-120-15.rdu2.redhat.com [10.10.120.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1748160493;
        Wed, 20 Nov 2019 13:33:05 +0000 (UTC)
Date:   Wed, 20 Nov 2019 08:33:03 -0500
From:   Neil Horman <nhorman@redhat.com>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>
Subject: Re: [PATCH v25 09/12] LRNG - add Jitter RNG fast noise source
Message-ID: <20191120133303.GA28341@hmswarspite.think-freely.org>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
 <2787174.DQlWHN5GGo@positron.chronox.de>
 <2377947.mlgTlHak1g@positron.chronox.de>
MIME-Version: 1.0
In-Reply-To: <2377947.mlgTlHak1g@positron.chronox.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jkXhu30zOsioLGVu8LUIDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Nov 16, 2019 at 10:36:52AM +0100, Stephan M=FCller wrote:
> The Jitter RNG fast noise source implemented as part of the kernel
> crypto API is queried for 256 bits of entropy at the time the seed
> buffer managed by the LRNG is about to be filled.
>=20
> CC: "Eric W. Biederman" <ebiederm@xmission.com>
> CC: "Alexander E. Patrakov" <patrakov@gmail.com>
> CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
> CC: "Theodore Y. Ts'o" <tytso@mit.edu>
> CC: Willy Tarreau <w@1wt.eu>
> CC: Matthew Garrett <mjg59@srcf.ucam.org>
> CC: Vito Caputo <vcaputo@pengaru.com>
> CC: Andreas Dilger <adilger.kernel@dilger.ca>
> CC: Jan Kara <jack@suse.cz>
> CC: Ray Strode <rstrode@redhat.com>
> CC: William Jon McCann <mccann@jhu.edu>
> CC: zhangjs <zachary@baishancloud.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Florian Weimer <fweimer@redhat.com>
> CC: Lennart Poettering <mzxreary@0pointer.de>
> CC: Nicolai Stange <nstange@suse.de>
> Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
> Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> Tested-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  drivers/char/lrng/Kconfig     | 11 +++++
>  drivers/char/lrng/Makefile    |  1 +
>  drivers/char/lrng/lrng_jent.c | 88 +++++++++++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+)
>  create mode 100644 drivers/char/lrng/lrng_jent.c
>=20
> diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> index 03e6e2ec356b..80fc723c67d2 100644
> --- a/drivers/char/lrng/Kconfig
> +++ b/drivers/char/lrng/Kconfig
> @@ -80,4 +80,15 @@ config LRNG_KCAPI
>  =09  provided by the selected kernel crypto API RNG.
>  endif # LRNG_DRNG_SWITCH
> =20
> +config LRNG_JENT
> +=09bool "Enable Jitter RNG as LRNG Seed Source"
> +=09select CRYPTO_JITTERENTROPY
> +=09help
> +=09  The Linux RNG may use the Jitter RNG as noise source. Enabling
> +=09  this option enables the use of the Jitter RNG. Its default
> +=09  entropy level is 16 bits of entropy per 256 data bits delivered
> +=09  by the Jitter RNG. This entropy level can be changed at boot
> +=09  time or at runtime with the lrng_base.jitterrng configuration
> +=09  variable.
> +
>  endif # LRNG
> diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
> index 027b6ea51c20..a87d800c9aae 100644
> --- a/drivers/char/lrng/Makefile
> +++ b/drivers/char/lrng/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_SYSCTL)=09=09+=3D lrng_proc.o
>  obj-$(CONFIG_LRNG_DRNG_SWITCH)=09+=3D lrng_switch.o
>  obj-$(CONFIG_LRNG_DRBG)=09=09+=3D lrng_drbg.o
>  obj-$(CONFIG_LRNG_KCAPI)=09+=3D lrng_kcapi.o
> +obj-$(CONFIG_LRNG_JENT)=09=09+=3D lrng_jent.o
> diff --git a/drivers/char/lrng/lrng_jent.c b/drivers/char/lrng/lrng_jent.=
c
> new file mode 100644
> index 000000000000..43114a44b8f5
> --- /dev/null
> +++ b/drivers/char/lrng/lrng_jent.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * LRNG Fast Noise Source: Jitter RNG
> + *
> + * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include "lrng_internal.h"
> +
> +/*
> + * Estimated entropy of data is a 16th of LRNG_DRNG_SECURITY_STRENGTH_BI=
TS.
> + * Albeit a full entropy assessment is provided for the noise source ind=
icating
> + * that it provides high entropy rates and considering that it deactivat=
es
> + * when it detects insufficient hardware, the chosen under estimation of
> + * entropy is considered to be acceptable to all reviewers.
> + */
> +static u32 jitterrng =3D LRNG_DRNG_SECURITY_STRENGTH_BITS>>4;
> +module_param(jitterrng, uint, 0644);
> +MODULE_PARM_DESC(jitterrng, "Entropy in bits of 256 data bits from Jitte=
r "
> +=09=09=09    "RNG noise source");
> +
> +/**
> + * Get Jitter RNG entropy
> + *
> + * @outbuf buffer to store entropy
> + * @outbuflen length of buffer
> + * @return > 0 on success where value provides the added entropy in bits
> + *=09   0 if no fast source was available
> + */
> +struct rand_data;
> +struct rand_data *jent_lrng_entropy_collector(void);
> +int jent_read_entropy(struct rand_data *ec, unsigned char *data,
> +=09=09      unsigned int len);
> +static struct rand_data *lrng_jent_state;
> +
> +u32 lrng_get_jent(u8 *outbuf, unsigned int outbuflen)
> +{
> +=09int ret;
> +=09u32 ent_bits =3D jitterrng;
> +=09unsigned long flags;
> +=09static DEFINE_SPINLOCK(lrng_jent_lock);
> +=09static int lrng_jent_initialized =3D 0;
> +
> +=09spin_lock_irqsave(&lrng_jent_lock, flags);
> +
> +=09if (!ent_bits || (lrng_jent_initialized =3D=3D -1)) {
> +=09=09spin_unlock_irqrestore(&lrng_jent_lock, flags);
> +=09=09return 0;
> +=09}
> +
this works, but I think you can avoid the use of the spin lock on the read =
calls
here.  If you assign a global pointer to the value of &lrng_jent_state on i=
nit,
you can just take the spinlock on assignment, and assume its stable after t=
hat
(which it should be given that its only ever going to point to a static dat=
a
structure).

Neil

> +=09if (!lrng_jent_initialized) {
> +=09=09lrng_jent_state =3D jent_lrng_entropy_collector();
> +=09=09if (!lrng_jent_state) {
> +=09=09=09jitterrng =3D 0;
> +=09=09=09lrng_jent_initialized =3D -1;
> +=09=09=09spin_unlock_irqrestore(&lrng_jent_lock, flags);
> +=09=09=09pr_info("Jitter RNG unusable on current system\n");
> +=09=09=09return 0;
> +=09=09}
> +=09=09lrng_jent_initialized =3D 1;
> +=09=09pr_debug("Jitter RNG working on current system\n");
> +=09}
> +=09ret =3D jent_read_entropy(lrng_jent_state, outbuf, outbuflen);
> +=09spin_unlock_irqrestore(&lrng_jent_lock, flags);
> +
> +=09if (ret) {
> +=09=09pr_debug("Jitter RNG failed with %d\n", ret);
> +=09=09return 0;
> +=09}
> +
> +=09/* Obtain entropy statement */
> +=09if (outbuflen !=3D LRNG_DRNG_SECURITY_STRENGTH_BYTES)
> +=09=09ent_bits =3D (ent_bits * outbuflen<<3) /
> +=09=09=09   LRNG_DRNG_SECURITY_STRENGTH_BITS;
> +=09/* Cap entropy to buffer size in bits */
> +=09ent_bits =3D min_t(u32, ent_bits, outbuflen<<3);
> +=09pr_debug("obtained %u bits of entropy from Jitter RNG noise source\n"=
,
> +=09=09 ent_bits);
> +
> +=09return ent_bits;
> +}
> +
> +u32 lrng_jent_entropylevel(void)
> +{
> +=09return min_t(u32, jitterrng, LRNG_DRNG_SECURITY_STRENGTH_BITS);
> +}
> --=20
> 2.23.0
>=20
>=20
>=20
>=20

