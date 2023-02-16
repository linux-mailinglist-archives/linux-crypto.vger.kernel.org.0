Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A258B699357
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Feb 2023 12:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBPLkx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Feb 2023 06:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBPLkw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Feb 2023 06:40:52 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8EE6A61
        for <linux-crypto@vger.kernel.org>; Thu, 16 Feb 2023 03:40:51 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id he33so4375091ejc.11
        for <linux-crypto@vger.kernel.org>; Thu, 16 Feb 2023 03:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hrgUxFedjti7TQosgzsXJfPwpACpM3jDB7nfCX1lUc4=;
        b=QXyjurBNmCZDNEe15js7QcGnKjrvEI2li/PVAQ3+TvfjbRmsCwtZ2VZOo+auooER4q
         Gq6avsPrdFKY1Ql9x23iEvAswG/ShdFQ1ZmZwZE0KJIPFZapzdjiUWSOEH1AFHKYpwXk
         dnH5EV4wWCtAVpcDvABh3HZuDCFziD68gkjahEoNSX2P99UlD0fJY81dGWNEc3380DjQ
         9mgiRveg2GkIUWYEIBMUSAQusA+VT8PPEmXDzs4pzCJrpYTT5EZCG4+Mlm89Ot2CjBNQ
         6/r3yZyHVS8w/8/BFUduOuQSsGKLJfiuAa02c4hGqa1dO6wXp6Yfxp5CGX7BsRivOx4g
         lHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrgUxFedjti7TQosgzsXJfPwpACpM3jDB7nfCX1lUc4=;
        b=u7mLqFNprfbTMBZrJHR98aIAiPjyWUhX0+j+romcOfvCeFqBwYVwutjTIDuCvGUgda
         wDMtAsLi7+MHe4aAfqKkolDhELb1fv+yQi6TxrnMZydroSpz1GHSS15YMpddA8PooakC
         0OXRQc68Qax5QNJ52UoMwecACscBSlLFLY0cZkKf0qBfExAhqOuZfk0sCz0xDA3/5PSn
         AaQOekTONf9+HxASyLqZ3uhb1DluiC1cbevfoIfTZc5PflAVGsQZIRZC4N6xkosYs+Bt
         QNT6ksqEykeYyjW66hRFaoEzWfe/Nn3Vfj6djOtl0GkexigJfuZ9WAGgz9ySyam9j+ts
         iqKQ==
X-Gm-Message-State: AO0yUKW7VABBixsyPme/GsxdtIoBF/iM7he6ul/dRvBBvPUEPPrLO/vi
        UfgDZBE9JcySzXsgD63cgD3PnZmaCGLeiDcV7kY=
X-Google-Smtp-Source: AK7set/rHBj71oobCom6FytDi5B8NItwqqPs4yHED64DBTR6sXB8x8nhDkID4rnWXfxcykOSUoQHHSUCed0gc20+0y8=
X-Received: by 2002:a17:906:cc88:b0:878:4a24:1a5c with SMTP id
 oq8-20020a170906cc8800b008784a241a5cmr2737790ejb.6.1676547650398; Thu, 16 Feb
 2023 03:40:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:5482:b0:62:8a9d:63db with HTTP; Thu, 16 Feb 2023
 03:40:49 -0800 (PST)
From:   SFG Finance <simab.projet@gmail.com>
Date:   Thu, 16 Feb 2023 12:40:49 +0100
Message-ID: <CAJQMEn6yD92PLbF7ZoCWPoev6R-XDq2Corue5WJM10Qw-Xc_LA@mail.gmail.com>
Subject: =?UTF-8?B?SsOTIFJFR0dFTFQgS8ONVsOBTk9L?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--=20
Az SFG Finance strukt=C3=BAra p=C3=A9nz=C3=BCgyi seg=C3=ADts=C3=A9get ny=C3=
=BAjt a vil=C3=A1g b=C3=A1rmely pontj=C3=A1n
lak=C3=B3hellyel rendelkez=C5=91 term=C3=A9szetes vagy jogi szem=C3=A9lynek=
.
Seg=C3=ADts=C3=A9gre van sz=C3=BCks=C3=A9ge a napi finansz=C3=ADroz=C3=A1si=
 probl=C3=A9m=C3=A1k megold=C3=A1s=C3=A1hoz?
Mennyire van sz=C3=BCks=C3=A9ged ?
Most vagy soha.
L=C3=A9pjen kapcsolatba finansz=C3=ADroz=C3=A1si csoportunkkal a Facebook M=
essengeren:
https://www.facebook.com/sfg.finances
VAGY E-mailben: sg.finance@gmail.com
