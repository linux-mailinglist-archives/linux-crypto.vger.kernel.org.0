Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9DA30539B
	for <lists+linux-crypto@lfdr.de>; Wed, 27 Jan 2021 07:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhA0Gx1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 Jan 2021 01:53:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:34522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232050AbhA0GvI (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 Jan 2021 01:51:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75157ACAC;
        Wed, 27 Jan 2021 06:50:25 +0000 (UTC)
Date:   Wed, 27 Jan 2021 07:50:23 +0100
Message-ID: <s5hlfcezxe8.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        dri-devel@lists.freedesktop.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        kvm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-watchdog@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 4/5] amba: Make the remove callback return void
In-Reply-To: <20210126165835.687514-5-u.kleine-koenig@pengutronix.de>
References: <20210126165835.687514-1-u.kleine-koenig@pengutronix.de>
        <20210126165835.687514-5-u.kleine-koenig@pengutronix.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 26 Jan 2021 17:58:34 +0100,
Uwe Kleine-König wrote:
> 
> All amba drivers return 0 in their remove callback. Together with the
> driver core ignoring the return value anyhow, it doesn't make sense to
> return a value here.
> 
> Change the remove prototype to return void, which makes it explicit that
> returning an error value doesn't work as expected. This simplifies changing
> the core remove callback to return void, too.
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org> # for drivers/memory
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/amba/bus.c                                 | 5 ++---
>  drivers/char/hw_random/nomadik-rng.c               | 3 +--
>  drivers/dma/pl330.c                                | 3 +--
>  drivers/gpu/drm/pl111/pl111_drv.c                  | 4 +---
>  drivers/hwtracing/coresight/coresight-catu.c       | 3 +--
>  drivers/hwtracing/coresight/coresight-cpu-debug.c  | 4 +---
>  drivers/hwtracing/coresight/coresight-cti-core.c   | 4 +---
>  drivers/hwtracing/coresight/coresight-etb10.c      | 4 +---
>  drivers/hwtracing/coresight/coresight-etm3x-core.c | 4 +---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 +---
>  drivers/hwtracing/coresight/coresight-funnel.c     | 4 ++--
>  drivers/hwtracing/coresight/coresight-replicator.c | 4 ++--
>  drivers/hwtracing/coresight/coresight-stm.c        | 4 +---
>  drivers/hwtracing/coresight/coresight-tmc-core.c   | 4 +---
>  drivers/hwtracing/coresight/coresight-tpiu.c       | 4 +---
>  drivers/i2c/busses/i2c-nomadik.c                   | 4 +---
>  drivers/input/serio/ambakmi.c                      | 3 +--
>  drivers/memory/pl172.c                             | 4 +---
>  drivers/memory/pl353-smc.c                         | 4 +---
>  drivers/mmc/host/mmci.c                            | 4 +---
>  drivers/rtc/rtc-pl030.c                            | 4 +---
>  drivers/rtc/rtc-pl031.c                            | 4 +---
>  drivers/spi/spi-pl022.c                            | 5 ++---
>  drivers/tty/serial/amba-pl010.c                    | 4 +---
>  drivers/tty/serial/amba-pl011.c                    | 3 +--
>  drivers/vfio/platform/vfio_amba.c                  | 3 +--
>  drivers/video/fbdev/amba-clcd.c                    | 4 +---
>  drivers/watchdog/sp805_wdt.c                       | 4 +---
>  include/linux/amba/bus.h                           | 2 +-
>  sound/arm/aaci.c                                   | 4 +---

For the sound/*:
Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
