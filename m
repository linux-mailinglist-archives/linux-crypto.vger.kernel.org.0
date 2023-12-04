Return-Path: <linux-crypto+bounces-537-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A238803718
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Dec 2023 15:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779E11C20A26
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Dec 2023 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5128E08
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Dec 2023 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVhRD2HI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB95DDF;
	Mon,  4 Dec 2023 04:56:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce387bcb06so628336b3a.0;
        Mon, 04 Dec 2023 04:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701694600; x=1702299400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SiTkejtvRYVLhFZqAXG9p6TOPgqQOE7vaa3in2MHCt4=;
        b=ZVhRD2HIC8xAsubofu9ieu2G2Lf/WZ4hANay+NQrtjO6VMmweoF4yEUFW0qz2zFevs
         4BdHITMnv2ao66/eV9yWmbQnZInUXx8Je04ejBmMPouf4DrVJq/1GGvEJrmjBd1Me6J5
         whK1zH+0epNYiNhBzL0L0Go8r0/KF6Tyn3WPNHR7uULxYzM5UQZSjjpvX8t0VhpYDIch
         7hENSRH6piKiSxHppD3ZVz7YXkjHMQXXdDor8rhXJVnrxCfwifYg3RGsWk61NurWaVui
         j9Bg5HFDBLGt4PQDynPnggX2DHKfPGPnp+EZNqq1iCqVxoNv2IOpxcS8fVKvIzqog76l
         uTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694600; x=1702299400;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SiTkejtvRYVLhFZqAXG9p6TOPgqQOE7vaa3in2MHCt4=;
        b=WcXNz9+IyHe6uZ+V2ioohU5aSN/vDT5WtoWQSn04D6XaDnt0okKOL0XyfMlfnbNvER
         ucs70nxdcbxPGj9rD4srUfAAKtsgkNX9DxKMuwkzT9DSCobw8PCbFbZvbqoAPyVa5RBT
         uphQstRr+e5mBbVg/ltEKcz/O+UUgfr9Abx5JHCk3DNo6NqPlLe4hZ9OECOtjYp9inAf
         uZZfrc55ILv/D1IZujDPNhlysc7yduvbeJBQpaXc2u1CiAMqT9CNm7CqxdiekiusMdIh
         p3u7t0IJpKoR3hJQL6S9Wa7ky0xEISrJMkOyYAe2/SUWfyO2xsW4Op7wExF6BxDQ/uOs
         gbYw==
X-Gm-Message-State: AOJu0Ywvkge+zmo+SRHR9kbp/9iJ9xCVgCDG/i+MNxtZLk2QzWxEsbzh
	5Ssp138wB9sQ3MH2rideRSa6MmFCgIGRbC0KPgM=
X-Google-Smtp-Source: AGHT+IF2aGT8hDg7ETvZLRKXX9I5/MjXS1Njyqa5rTCmPrtZiOHhjI0KlyEesJYWGSW1HARZzt7rbLa+CFtT4lF3BqQ=
X-Received: by 2002:a05:6a21:1c84:b0:18f:97c:8258 with SMTP id
 sf4-20020a056a211c8400b0018f097c8258mr1282336pzb.98.1701694599894; Mon, 04
 Dec 2023 04:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 4 Dec 2023 20:56:27 +0800
Message-ID: <CABOYnLzjtGnP35qE3VVyiu_mawizPtiugFATSaWwmdL1w+pqWA@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
To: syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com
Cc: davem@davemloft.net, glider@google.com, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello
I reproduced this bug with repro.c and repro.txt
Because the file is relatively large, please see
https://gist.github.com/xrivendell7/c7bb6ddde87a892818ed1ce206a429c4

