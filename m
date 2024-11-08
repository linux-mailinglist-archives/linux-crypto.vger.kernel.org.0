Return-Path: <linux-crypto+bounces-7980-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F09C144D
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2024 03:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DED1C222E0
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2024 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B061FFE;
	Fri,  8 Nov 2024 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FceFVNPq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF922F85C
	for <linux-crypto@vger.kernel.org>; Fri,  8 Nov 2024 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034446; cv=none; b=CQg61/dcEOmrslc7z5wVDMBvx7ZR4SBr2WwgWxljwHTBw5jgK9or1PPGQpY2QaMKYFHtyEcng9BV/NMWn7Vt7lvQpgX0fG6Hl6jUsuyG/RB60jPoT6h/0irtb1fTpPryQLabnGYMI9KXy6d4EioBmGX5qa7qBp3NHJ1luSdQrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034446; c=relaxed/simple;
	bh=cwEqbnHj/TJxnIy+3o2VhKgoUs8GcxvB6wBbbqhMWAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jx40KfGi1Jz9I/2Ahf8rvM+ZVOE4GxPNmZ5ec6neKIPawQGKOZ+tuPxKtMgzh+wn1j6qgfeYOOy0Jr0OlRBS82AQTq7zxTreV0gwFFgo3lNMtxbysgk00z64cuf9kWiIaQg07oAA7OGuogl1Xw/1kmDM1FdviXlDGi01RnOQAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FceFVNPq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731034443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwEqbnHj/TJxnIy+3o2VhKgoUs8GcxvB6wBbbqhMWAU=;
	b=FceFVNPq5l8l8Sdw4km5N5zUPFVPGe1D8/Z2oOrdlpoDmQ0bZiUbbNIpdymQ4+3F4i2cIA
	4HQ5dxTU0TGp1gswhsHz0yZ76phoX/VnR8EkdIlIbRWWegVWLMY7GdxudKt6dpdY33lYnd
	UdVrE+YvHccYkWWNv2OV0yY3RtgdJv8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-aDTNigNFPuCyCs2po0g3yQ-1; Thu, 07 Nov 2024 21:54:02 -0500
X-MC-Unique: aDTNigNFPuCyCs2po0g3yQ-1
X-Mimecast-MFC-AGG-ID: aDTNigNFPuCyCs2po0g3yQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e76eabc7ddso1886061a91.3
        for <linux-crypto@vger.kernel.org>; Thu, 07 Nov 2024 18:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034441; x=1731639241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwEqbnHj/TJxnIy+3o2VhKgoUs8GcxvB6wBbbqhMWAU=;
        b=r4vzjJSHODPdfgHS/CNK5XFrx7NenXobDX8q0rYJYDkkSqhrcN3pN+sXouikE96Xnp
         jWzMD5pfpSwWmme/dRREiFw+QSVlYg496rJr+M5A7w6QXt1VvUIxOl/O7XGKjGeD3fzt
         l11hto10SN4GVW2FeqvHaZsQJjpU59gbXEzCXrN/3+k02bhrid0Ns3JZfg6R8NkFfh3+
         MjWBbIpPbsjAau+ETTBcoJlF0pf1EgOttOZQxlwVrVRsVTT4j5QGaDR86eSYaO+RSy29
         1GB1bN6AZrBQbggWNkVIzbsa+UHzrxITyZ5RBB75tBqYGUDCEF9vDYxU62gkO/D1FAnt
         XUTw==
X-Forwarded-Encrypted: i=1; AJvYcCX1MkU8FAUOFrTr7QIwme1QUd5XEzSHAAqQGPmzarTIs2jbhE1jN2ip/KOtnK0RcvbowdhiKoq2KLayjpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqWXbHkDgt9La0rxychrqkY0kT/BXf97Be6TTUldyrE7gHVSH
	Ms5LvECCGLvtPDZYPx1tqp0Ax9LYfiapAjiPJ5pBh6qMcxIgIpxmO5UV2AHjPzpnh2oSjQB96FS
	lFF/UoOYdifTw0amWwOcAjrWYjSS+E4O+37MG/WvnzIydl9VPbXfAFZGeS+0ER2shiMh36q5Xti
	+1v04bk8w3eVZwysOiAtbK22DCiKjaogloQWKr
X-Received: by 2002:a17:90b:3d91:b0:2e2:a029:3b4b with SMTP id 98e67ed59e1d1-2e9b177632bmr1984101a91.28.1731034440895;
        Thu, 07 Nov 2024 18:54:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeAKu6FXOO8aouj3/WFxZQgxhtW8ocCUmDNXhuRcpuePvBO35pclspRsjXFn6dE+pdWYMrEjjMCT0rnXoNyZM=
X-Received: by 2002:a17:90b:3d91:b0:2e2:a029:3b4b with SMTP id
 98e67ed59e1d1-2e9b177632bmr1984080a91.28.1731034440508; Thu, 07 Nov 2024
 18:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031030847.3253873-1-qiang4.zhang@linux.intel.com>
 <20241101015101.98111-1-qiang4.zhang@linux.intel.com> <CACGkMEtvrBRd8BaeUiR6bm1xVX4KUGa83s03tPWPHB2U0mYfLA@mail.gmail.com>
 <20241106042828-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241106042828-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Nov 2024 10:53:49 +0800
Message-ID: <CACGkMEv4eq9Ej2d2vKp0S8UdTgf4tjXJ_SAtfZmKxQ3iPxfEOg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: only reset device and restore status if needed
 in device resume
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qiang4.zhang@linux.intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Qiang Zhang <qiang4.zhang@intel.com>, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Nov 01, 2024 at 10:11:11AM +0800, Jason Wang wrote:
> > On Fri, Nov 1, 2024 at 9:54=E2=80=AFAM <qiang4.zhang@linux.intel.com> w=
rote:
> > >
> > > From: Qiang Zhang <qiang4.zhang@intel.com>
> > >
> > > Virtio core unconditionally reset and restore status for all virtio
> > > devices before calling restore method. This breaks some virtio driver=
s
> > > which don't need to do anything in suspend and resume because they
> > > just want to keep device state retained.
> >
> > The challenge is how can driver know device doesn't need rest.
>
> I actually don't remember why do we do reset on restore. Do you?
>

Because the driver doesn't know if the device can keep its state, so
it chooses to start from that.

Thanks


