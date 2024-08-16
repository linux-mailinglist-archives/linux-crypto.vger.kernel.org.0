Return-Path: <linux-crypto+bounces-6048-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB93954AE6
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Aug 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031F01C223C1
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Aug 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A853A1B9B3A;
	Fri, 16 Aug 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b="f+n9RoPj"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.hotelshavens.com (mail.hotelshavens.com [217.156.64.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1551B8E9B
	for <linux-crypto@vger.kernel.org>; Fri, 16 Aug 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.156.64.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814468; cv=none; b=r1kScFOEfZzjBaVSn1Bummu4VuOwZGr7miFz3GAAdmujuhoAmpyyXDF0wIq5w9tbbjgP8doucgCSAa9phlz2SQL07pOVFLHZiDaHgMabfKu1P/tDp/UezN55RtdVM5sfKbdYOvEWaAshCbH11x1rgSBo/88k9XGKpYi9laG7fNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814468; c=relaxed/simple;
	bh=r4l0Uv1QmrsbC9d2C9TsMUv+sYz9DiTIILlGNyAKfiU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mP/8amjGbV0WrcYLaz/qbQbsr/ubTeU5sX58cGdMmpum01PrGrrEINK8aNyxw5PXL/ZR3CEKSCWUJ857xMrrb8K77WWSHuq92CFxRoiyhKI/+roYPKMjDsJA4+bHv+sWiTrPzHdhXQjflvpzwJKIAejmqiutD7NjLelkiMD13ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com; spf=pass smtp.mailfrom=hotelshavens.com; dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b=f+n9RoPj; arc=none smtp.client-ip=217.156.64.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotelshavens.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=dkim; d=hotelshavens.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=admin@hotelshavens.com;
 bh=r4l0Uv1QmrsbC9d2C9TsMUv+sYz9DiTIILlGNyAKfiU=;
 b=f+n9RoPjbYyeaVnYK6HDVZ0ti3FH47DSvZocpQmwqBRrRhEHbSiYWn5ERKuoxj3W7tIQqjOB7+a+
   1kX099fLvPj5HPZkfwxoe1oP6pRXwuEtxmurrIhC1yF7RjxP4a8aqBBH8F4MzBHnRGr1Qlnv+2sO
   EUAsZKQtqJYoZ2klC5zdkF/bB/JtU/OnrEoPJCQmG9RCvtRVwaoKlcfuVWLBN2IRDPLxIC3wDIFa
   WRLcabz7C1jVyyRuXxDftzfNvyUirnz2TZeaeGIlDQzByUQkh8IK2VTMrgpwUkB/mBBeUq7C9zsM
   szQqIYuB9yr867NrlxwXTfvV4gdyKX8YzrfuGKMEHjwVcUAzSW20KSLrYzUFyP+o67FWIfnoptZh
   x1qZYUbusXKPFQ+T4bLffLfQuXqkqXFCx8JsEnRufdljiLnDfqr3p66XGHFTY/uXoJr/sab2iKj7
   HUVHRuNWpSlmNXTiyG7bkfs4vsQmwEoKhn7WH6p+V2L3Giwl0VMioQhsimCJpSWdn1b7yv/MSAwE
   jK+XFwgM9ABfd8fT1NXsU2hoRh/7S5eSBhGaGGdYZA/R86QyRWSKSUvqVnPOjdw3gdkAixUOJosr
   4qFr6cNalB2mN7eWyeU+8SgJXSJR7G4Hf9CrktjIHQ894/dO6G9ronyz0EIuFwigRqEzLGLef6Q=
Reply-To: boris@undpkh.com
From: Boris Soroka <admin@hotelshavens.com>
To: linux-crypto@vger.kernel.org
Subject: HI DEAR !
Date: 16 Aug 2024 15:15:42 +0200
Message-ID: <20240816134828.401D781D3E8292CE@hotelshavens.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

Did you receive my last email message I sent to this Email=20
address: ( linux-crypto@vger.kernel.org ) concerning relocating=20
my investment to your country due to the on going war in my=20
country Russia.

Best Regards,
Mr.Boris Soroka.

