Return-Path: <linux-crypto+bounces-1029-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248E81E114
	for <lists+linux-crypto@lfdr.de>; Mon, 25 Dec 2023 15:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BD91C219F1
	for <lists+linux-crypto@lfdr.de>; Mon, 25 Dec 2023 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB7524D1;
	Mon, 25 Dec 2023 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXJe0TZN"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92E524B8
	for <linux-crypto@vger.kernel.org>; Mon, 25 Dec 2023 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703513184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sbPsD815Mv6jt+X0ZxPPC1XKV02PnoGH57lDKIhFvZQ=;
	b=FXJe0TZNfOUojywWv1zC6cLyY+LVAGfkR9+t05w1nGX+Lvc/uqf4Q9Ve8m9UXpJrGCqJi9
	UGaI+zLSlISxE17nmYpPQXGP+n1OMV0/fH1lcPe7Lzr4+ySW/S9STzJUP2NRjn7xHWhnYZ
	Y6wJEQ1OMM1iCbMD5GhRy81exYcsBD4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-t2A5F94XOZufgOGm8jLSow-1; Mon, 25 Dec 2023 09:06:22 -0500
X-MC-Unique: t2A5F94XOZufgOGm8jLSow-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d55db5a06so9747505e9.1
        for <linux-crypto@vger.kernel.org>; Mon, 25 Dec 2023 06:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703513182; x=1704117982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbPsD815Mv6jt+X0ZxPPC1XKV02PnoGH57lDKIhFvZQ=;
        b=YcPBwEJs7nKLBGR4qfk9YCfnKBCAXZRpLj5htcBxImQCC2JII+LJpRf+1JLR1Jhm90
         oxzXK8SoH5/dhQF2lrZNbQQqbfzldgEQkWRcJiC2kzu26qHHDfGNqTZtrHbvN8XcqeNE
         eATt0ieJ+CjOT1eLWAqPjMJqbU7NVEXNpWBvBUKJ7+xyVjAKvltSV3HEMPGqsIuMSXbp
         XKXukoB1a+5KmyuEtXnbhPNsdYUHrgrmEjFLZop1ElmCvOiYj1mKaTnOnvgCU4B88tzd
         lEfffY6fML+8ZeX184jsPNaEFKdGnFHrOMONYEOX/VXrYRxZcT1rxp02HoATQC5SC05A
         ESuQ==
X-Gm-Message-State: AOJu0Yx+V+gi77NnQ5BQeJpmOw3ip7oZrljkEug9ASdPxkCW7OmXWPVP
	e2gvgJULZxQCI4rnCk536lhMHlLzQqndZbe4H+94+HJTVwFSWlzSGWSOKOcLm1kbL11e8qHhGiP
	4Vw27eRdpyD5uNF31RP6gIswfFYkiNi+v
X-Received: by 2002:a05:600c:3c97:b0:40c:2548:2e29 with SMTP id bg23-20020a05600c3c9700b0040c25482e29mr1894102wmb.334.1703513181849;
        Mon, 25 Dec 2023 06:06:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU9yN9B/S7kjrGkO269+hGYIEciicmdgOUUweSOTjBYpROCXhGDR4myECgkfJzm8/hWBY7oA==
X-Received: by 2002:a05:600c:3c97:b0:40c:2548:2e29 with SMTP id bg23-20020a05600c3c9700b0040c25482e29mr1894095wmb.334.1703513181522;
        Mon, 25 Dec 2023 06:06:21 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0040d5335079dsm6956070wmb.47.2023.12.25.06.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 06:06:20 -0800 (PST)
Date: Mon, 25 Dec 2023 09:06:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Olivia Mackall <olivia@selenic.com>,
	Petre Eftime <petre.eftime@gmail.com>,
	Erdem Meydanlli <meydanli@amazon.nl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v7] misc: Add Nitro Secure Module driver
Message-ID: <20231225090044-mutt-send-email-mst@kernel.org>
References: <20231011213522.51781-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011213522.51781-1-graf@amazon.com>

On Wed, Oct 11, 2023 at 09:35:22PM +0000, Alexander Graf wrote:
> When running Linux inside a Nitro Enclave, the hypervisor provides a
> special virtio device called "Nitro Security Module" (NSM). This device
> has 3 main functions:
> 
>   1) Provide attestation reports
>   2) Modify PCR state
>   3) Provide entropy
> 
> This patch adds a driver for NSM that exposes a /dev/nsm device node which
> user space can issue an ioctl on this device with raw NSM CBOR formatted
> commands to request attestation documents, influence PCR states, read
> entropy and enumerate status of the device. In addition, the driver
> implements a hwrng backend.
> 
> Originally-by: Petre Eftime <petre.eftime@gmail.com>
> Signed-off-by: Alexander Graf <graf@amazon.com>

Alex are you going to publish the spec patch for this device?  Important
so we don't need to guess at behaviour when e.g.  making changes to
virtio APIs.  Also, which tree do you want this to go through?

-- 
MST


