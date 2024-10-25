Return-Path: <linux-crypto+bounces-7626-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B49B09E6
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Oct 2024 18:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB241C21D33
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Oct 2024 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5A618C000;
	Fri, 25 Oct 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXWr+ROG"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6230186298
	for <linux-crypto@vger.kernel.org>; Fri, 25 Oct 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873533; cv=none; b=k+DdkaBR7F0QaX4riRnrNVpvQGTGS2vcnwFg27aTKg7IIUC+askoaMlQS1rpgJ8Rm9d/NRSoyrkFqPQ74vhbW+NmRhl2HvDZjCphb9CLJB0XfMxx6c8f1nn3ETy+3qpYA7FTiaXgfeMsmV+U9NrwyBJSQ47RJCgrd2WLijMaZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873533; c=relaxed/simple;
	bh=GoCr76xnRLzwQicFvt18Ge2EG7K2EG1pjibQU3pXtS8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OTveY2rcNvs84speboPytlQllUSvVfSLjkZJRY7qGeA0pfFDpSjeq5AmM3xfR2RPiHOLvOG+HyDqukuGW4QBkifAJuKZwINXh1I0qhBPOGBCP7efBKKWCR1h2i7L7T3xA9OZ6lT20Rwo9c6gEiLsMoE9++ZY9KUF8/pm5lP8dO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXWr+ROG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729873529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXKBVRfqpqNYlcZq3IctC1VfdYCiTtVmRZFO4m6wOiI=;
	b=PXWr+ROGG0emiHa0EuaCbQ5uB40dzMfT7nmVFnkfg9JVVuqAVbjVLsxkIeXHcfnI2XWm04
	V2y4xWfkoRnmyu15ERBqELs7+fX1ta0AnisN8b6qz6a11WMm6ubj/UL0izG2YpNMukgNVz
	5uA96musoY3r7GlFkPpp+ZOTCHa5g8k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-2x5z569eNr-cXJv9n0_3YA-1; Fri, 25 Oct 2024 12:25:28 -0400
X-MC-Unique: 2x5z569eNr-cXJv9n0_3YA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53a246ecb7bso1971618e87.2
        for <linux-crypto@vger.kernel.org>; Fri, 25 Oct 2024 09:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873527; x=1730478327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXKBVRfqpqNYlcZq3IctC1VfdYCiTtVmRZFO4m6wOiI=;
        b=bo13YgZLi0oLGEz+r3PkhbobRDzLuMYigsjm9CX56pvQsaFQ9S7q88WwZ84klp4eca
         tSj4PDopCpUDw3/ra2BLKECBzy6ch/HRr6wI1NhuFks47QLdWVDqvCf837GNiArcvXIz
         gmG9k2S+JiRMIVRmH1lf4GRoPU0GpesVBligfWKECchwiyWkKrWOdMefJhD2XlcXkDBO
         7GIeW9nc44P+pRl3mLCXqkPa7IS82i1F5nVIjCVTriptYiPLsBvSyOEEOKEpizha2xoO
         yranepOYu7kw4KaGm0joJSR00R3TmXAU3sEcmSrCucNpSct93mMqavvR3dIZjeGMpPCU
         B1VA==
X-Forwarded-Encrypted: i=1; AJvYcCXWWO0mMIu4VSlKdwNpRANk6gQdj7an7w5ce71xiBNmIkREAq81sAY2aSlPtH3SF4R5tuNCOZD/gRyRqQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0kFnyCxlFBksy6StWoifJ3ZHO067MYFHL1HHr1SkCjCWabg5
	/tjA5YKHlHnLkMIJxY17oQfL1h2x/VkAar/S6BADm5F8aDvMIATUJtQjU/7qeMPWhxVhIcwLhMQ
	Nrxc6Hqf7Uxp9fOmWgUdjNHwUB0vNO83yHLWbM4vqrI13iLcCcm9/4zb6ohjKww==
X-Received: by 2002:a05:6512:ad5:b0:539:e2cc:d380 with SMTP id 2adb3069b0e04-53b1a341cb6mr5563346e87.27.1729873527037;
        Fri, 25 Oct 2024 09:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvcz2ftuWzZl9pExVs36p45/rF+DcGN9KaPbit+tdC2ctJlDRbjLwxBhAN9fei+TzzB/5ozg==
X-Received: by 2002:a05:6512:ad5:b0:539:e2cc:d380 with SMTP id 2adb3069b0e04-53b1a341cb6mr5563310e87.27.1729873526521;
        Fri, 25 Oct 2024 09:25:26 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a08b478sm86191966b.223.2024.10.25.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:25:26 -0700 (PDT)
Message-ID: <18fa3bec44aaee473f9d0955891fc63300400de7.camel@redhat.com>
Subject: Re: [PATCH 06/10] wifi: iwlwifi: replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,  Boris Brezillon
 <bbrezillon@kernel.org>, Arnaud Ebalard <arno@natisbad.org>, Srujana Challa
 <schalla@marvell.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Serge
 Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Kevin Cernekee <cernekee@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>,  Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Jie Wang <jie.wang@intel.com>, Tero
 Kristo <tero.kristo@linux.intel.com>, Adam Guerin <adam.guerin@intel.com>,
 Shashank Gupta <shashank.gupta@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Johannes Berg
 <johannes.berg@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
  Gregory Greenman <gregory.greenman@intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, linux-doc@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
 qat-linux@intel.com,  linux-crypto@vger.kernel.org,
 linux-wireless@vger.kernel.org,  ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>,
 linux-sound@vger.kernel.org
Date: Fri, 25 Oct 2024 18:25:24 +0200
In-Reply-To: <a3e6808f-195c-7174-64f9-a4392d7a02f0@linux.intel.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
	  <20241025145959.185373-7-pstanner@redhat.com>
	  <ea7b805a-6c8e-8060-1c6b-4d62c69f78ae@linux.intel.com>
	 <415402ba495b402b67ae9ece0ca96ab3ea5ee823.camel@redhat.com>
	 <a3e6808f-195c-7174-64f9-a4392d7a02f0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 19:11 +0300, Ilpo J=C3=A4rvinen wrote:
> On Fri, 25 Oct 2024, Philipp Stanner wrote:
>=20
> > On Fri, 2024-10-25 at 18:31 +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Fri, 25 Oct 2024, Philipp Stanner wrote:
> > >=20
> > > > pcim_iomap_table() and pcim_iomap_regions_request_all() have
> > > > been
> > > > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > > > Deprecate
> > > > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> > > >=20
> > > > Replace these functions with their successors, pcim_iomap() and
> > > > pcim_request_all_regions().
> > > >=20
> > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > Acked-by: Kalle Valo <kvalo@kernel.org>
> > > > ---
> > > > =C2=A0drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++----=
-
> > > > ----
> > > > ---
> > > > =C2=A01 file changed, 4 insertions(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > > b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > > index 3b9943eb6934..4b41613ad89d 100644
> > > > --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > > @@ -3533,7 +3533,6 @@ struct iwl_trans
> > > > *iwl_trans_pcie_alloc(struct
> > > > pci_dev *pdev,
> > > > =C2=A0	struct iwl_trans_pcie *trans_pcie, **priv;
> > > > =C2=A0	struct iwl_trans *trans;
> > > > =C2=A0	int ret, addr_size;
> > > > -	void __iomem * const *table;
> > > > =C2=A0	u32 bar0;
> > > > =C2=A0
> > > > =C2=A0	/* reassign our BAR 0 if invalid due to possible
> > > > runtime
> > > > PM races */
> > > > @@ -3659,22 +3658,15 @@ struct iwl_trans
> > > > *iwl_trans_pcie_alloc(struct pci_dev *pdev,
> > > > =C2=A0		}
> > > > =C2=A0	}
> > > > =C2=A0
> > > > -	ret =3D pcim_iomap_regions_request_all(pdev, BIT(0),
> > > > DRV_NAME);
> > > > +	ret =3D pcim_request_all_regions(pdev, DRV_NAME);
> > > > =C2=A0	if (ret) {
> > > > -		dev_err(&pdev->dev,
> > > > "pcim_iomap_regions_request_all failed\n");
> > > > +		dev_err(&pdev->dev, "pcim_request_all_regions
> > > > failed\n");
> > > > =C2=A0		goto out_no_pci;
> > > > =C2=A0	}
> > > > =C2=A0
> > > > -	table =3D pcim_iomap_table(pdev);
> > > > -	if (!table) {
> > > > -		dev_err(&pdev->dev, "pcim_iomap_table
> > > > failed\n");
> > > > -		ret =3D -ENOMEM;
> > > > -		goto out_no_pci;
> > > > -	}
> > > > -
> > > > -	trans_pcie->hw_base =3D table[0];
> > > > +	trans_pcie->hw_base =3D pcim_iomap(pdev, 0, 0);
> > > > =C2=A0	if (!trans_pcie->hw_base) {
> > > > -		dev_err(&pdev->dev, "couldn't find IO mem in
> > > > first
> > > > BAR\n");
> > > > +		dev_err(&pdev->dev, "pcim_iomap failed\n");
> > >=20
> > > This seems a step backwards as a human readable English error
> > > message
> > > was=20
> > > replaced with a reference to a function name.
> >=20
> > I think it's still an improvement because "couldn't find IO mem in
> > first BAR" is a nonsensical statement. What the author probably
> > meant
> > was: "Couldn't find first BAR's IO mem in magic pci_iomap_table" ;)
>=20
> Well, that's just spelling things on a too low level too. It's
> irrelevant
> detail to the _user_ that kernel used some "magic table". Similarly,
> it's=20
> irrelevant to the user that function called pcim_iomap failed.
>=20
> > The reason I just wrote "pcim_iomap failed\n" is that this seems to
> > be
> > this driver's style for those messages. See the dev_err() above,
> > there
> > they also just state that this or that function failed.
>=20
> The problem in using function names is they have obvious meaning for=20
> developers/coders but dev_err() is presented to user with varying
> level
> of knowledge about kernel internals/code.
>=20
> While users might be able to derive some information from the
> function=20
> name, it would be simply better to explain on higher level what
> failed=20
> which is what I think the original message tried to do even if it was
> a bit clumsy. There is zero need to know about kernel internals to=20
> interpret that message (arguably one needs to know some PCI to
> understand=20
> BAR, though).
>=20
> (Developers can find the internals by looking up the error message
> from
> the code so it doesn't take away something from developers.)

Feel free to make a suggestion for a better error message.

sth like "could not ioremap PCI BAR 0.\n" could satisfy your criteria.

(I just now noticed that so far it called BAR 0 the "first bar", which
is also not gold standard)

P.


>=20


