Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002DA42BFA6
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Oct 2021 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhJMMUK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 13 Oct 2021 08:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231919AbhJMMUJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 13 Oct 2021 08:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634127483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8uA+gFhUzMMrb5D5fxARTwQwcT+AEfWKWkQ0ooGMKj8=;
        b=gcZphIhv1SUibhOpSsOSgz4m0cbJvHyEtd0kwtKyNGk7PlE0SU+JPX+FUmjzkGHkvuPJuI
        RYeShTXWeJ1jx+SFek2K1Tc6X4vwuEpu4Q3Rv6491+05hOgYMfee2etkukNn00qGLGJeMY
        ljgHBxDZGBTUGlUD8++dZn6sdjVlaG0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-56nYX8c9P_O0OAk3TP7blA-1; Wed, 13 Oct 2021 08:18:02 -0400
X-MC-Unique: 56nYX8c9P_O0OAk3TP7blA-1
Received: by mail-wr1-f72.google.com with SMTP id h11-20020adfa4cb000000b00160c791a550so1835294wrb.6
        for <linux-crypto@vger.kernel.org>; Wed, 13 Oct 2021 05:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8uA+gFhUzMMrb5D5fxARTwQwcT+AEfWKWkQ0ooGMKj8=;
        b=pa21d9upjsF1BscY94dizjhX+rNH03r7b7U50QB5uq80I4jFbw0JWGI7hQT8e0elN5
         p0/AcqxHOcHLM5T91FwO3LFRJ9XA1JrjTc2fQIVz6ErAYdsG8cKeDnG2/EcIU+P1z9LU
         ethhSrap3JC5d6YWKS35fg60hqmkea+Iq/hmY4qevsddrlNrRRwCWDDD5BXjFa3INLv3
         9sqnjERMxPvFCWtePtN44F/zhevKtFl9umbAzpqcKJYZhO8dhgItk/IJ4swrVZmGWAb2
         nsisqHW8GsdEE+onjJcixwKgKw1+X/4njZrtnni6ER+CTfV6QmD1vmlw/CIraq/eVTSC
         k0Xw==
X-Gm-Message-State: AOAM533FOkJ39MlIt2I3w0akF2FwO7UjME/ixXVb8kH2TG9bhIXh0d3k
        ndadobuSCAT5OwGHy+rjNanCSwsORdhQttGAMn2w+9Ho9BmNuoBYu8CliiKFhlPldsHdl34Ycdb
        ScmLvzD75EeoGRr7e9DOFCxs4
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr12535222wmj.38.1634127481360;
        Wed, 13 Oct 2021 05:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFEzPqFQ+1qHznC4euH1QtbfXrvr/+t46tCqHwjpC6aqk2B2gJ30j5Cm2I+Hz0oA4zGN44UQ==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr12535146wmj.38.1634127481076;
        Wed, 13 Oct 2021 05:18:01 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id z1sm4104369wrt.94.2021.10.13.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:18:00 -0700 (PDT)
Date:   Wed, 13 Oct 2021 08:17:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gonglei <arei.gonglei@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jie Deng <jie.deng@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-um@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, kvm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <20211013081632-mutt-send-email-mst@kernel.org>
References: <20211013105226.20225-1-mst@redhat.com>
 <2060bd96-5884-a1b5-9f29-7fe670dc088d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2060bd96-5884-a1b5-9f29-7fe670dc088d@redhat.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Oct 13, 2021 at 01:03:46PM +0200, David Hildenbrand wrote:
> On 13.10.21 12:55, Michael S. Tsirkin wrote:
> > This will enable cleanups down the road.
> > The idea is to disable cbs, then add "flush_queued_cbs" callback
> > as a parameter, this way drivers can flush any work
> > queued after callbacks have been disabled.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   arch/um/drivers/virt-pci.c                 | 2 +-
> >   drivers/block/virtio_blk.c                 | 4 ++--
> >   drivers/bluetooth/virtio_bt.c              | 2 +-
> >   drivers/char/hw_random/virtio-rng.c        | 2 +-
> >   drivers/char/virtio_console.c              | 4 ++--
> >   drivers/crypto/virtio/virtio_crypto_core.c | 8 ++++----
> >   drivers/firmware/arm_scmi/virtio.c         | 2 +-
> >   drivers/gpio/gpio-virtio.c                 | 2 +-
> >   drivers/gpu/drm/virtio/virtgpu_kms.c       | 2 +-
> >   drivers/i2c/busses/i2c-virtio.c            | 2 +-
> >   drivers/iommu/virtio-iommu.c               | 2 +-
> >   drivers/net/caif/caif_virtio.c             | 2 +-
> >   drivers/net/virtio_net.c                   | 4 ++--
> >   drivers/net/wireless/mac80211_hwsim.c      | 2 +-
> >   drivers/nvdimm/virtio_pmem.c               | 2 +-
> >   drivers/rpmsg/virtio_rpmsg_bus.c           | 2 +-
> >   drivers/scsi/virtio_scsi.c                 | 2 +-
> >   drivers/virtio/virtio.c                    | 5 +++++
> >   drivers/virtio/virtio_balloon.c            | 2 +-
> >   drivers/virtio/virtio_input.c              | 2 +-
> >   drivers/virtio/virtio_mem.c                | 2 +-
> >   fs/fuse/virtio_fs.c                        | 4 ++--
> >   include/linux/virtio.h                     | 1 +
> >   net/9p/trans_virtio.c                      | 2 +-
> >   net/vmw_vsock/virtio_transport.c           | 4 ++--
> >   sound/virtio/virtio_card.c                 | 4 ++--
> >   26 files changed, 39 insertions(+), 33 deletions(-)
> > 
> > diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> > index c08066633023..22c4d87c9c15 100644
> > --- a/arch/um/drivers/virt-pci.c
> > +++ b/arch/um/drivers/virt-pci.c
> > @@ -616,7 +616,7 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
> >   	int i;
> >           /* Stop all virtqueues */
> > -        vdev->config->reset(vdev);
> > +        virtio_reset_device(vdev);
> >           vdev->config->del_vqs(vdev);
> 
> Nit: virtio_device_reset()?
> 
> Because I see:
> 
> int virtio_device_freeze(struct virtio_device *dev);
> int virtio_device_restore(struct virtio_device *dev);
> void virtio_device_ready(struct virtio_device *dev)
> 
> But well, there is:
> void virtio_break_device(struct virtio_device *dev);

Exactly. I don't know what's best, so I opted for plain english :)


> -- 
> Thanks,
> 
> David / dhildenb

