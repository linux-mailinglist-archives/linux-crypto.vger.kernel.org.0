Return-Path: <linux-crypto+bounces-9100-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B665FA143A2
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2025 21:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0191160E86
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2025 20:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620B2309B8;
	Thu, 16 Jan 2025 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mpd.biglobe.ne.jp header.i=@mpd.biglobe.ne.jp header.b="lMop1ep9"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mta-sndfb-e04.biglobe.ne.jp (mta-sndfb-e04.biglobe.ne.jp [27.86.113.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895C1946C3
	for <linux-crypto@vger.kernel.org>; Thu, 16 Jan 2025 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=27.86.113.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060762; cv=none; b=hioxpi9jt0pAez5STNHpvYxCWso1/5C2k+u9QF1AQ7sxUrpHe3VRCqRus+NlmpSpsrvKBVdtrdK1dfzphTu1Ch1GElEJ5zSCw4LW2P5mCutYABItuZkQrANQv9mlzupaLsQI9LUduaGpqjPwWLla2RFRCXtw3b95QiuVHMReQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060762; c=relaxed/simple;
	bh=mDQTv27cU6gzjBAUcsV7oAuMVuZbaqeERjhN0qxCvGQ=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=aybZWpANYJxnUf4uP33JJ1acSi/5j6Z66iPCQfA6kQvlXGp9Tm8TCtPUb0NjCWGKaKhxV5AGlsMOjOI8n1JWrURK/G0L8bdz94Z1IywrEMx0jdXzSx+TYuC8WAnQY8cbrlf+Yhy+JMlCBGxY+VzxV8exlhGMzzGxXrXHSvyFEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mpd.biglobe.ne.jp; spf=pass smtp.mailfrom=mpd.biglobe.ne.jp; dkim=pass (2048-bit key) header.d=mpd.biglobe.ne.jp header.i=@mpd.biglobe.ne.jp header.b=lMop1ep9; arc=none smtp.client-ip=27.86.113.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mpd.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpd.biglobe.ne.jp
Received: from mail.biglobe.ne.jp by mta-snd-e01.biglobe.ne.jp with ESMTP
          id <20250116204835516.KUPZ.94579.mail.biglobe.ne.jp@biglobe.ne.jp>
          for <linux-crypto@vger.kernel.org>;
          Fri, 17 Jan 2025 05:48:35 +0900
Message-ID: <a17da62719a0b42c6e40fd6ba0c7c02e73adccf9eb7dccb3022677e231c425ff@mpd.biglobe.ne.jp>
From: Mark Allan <sohma2763@mpd.biglobe.ne.jp>
Reply-To: recruitmentacy@gmail.com
To: linux-crypto@vger.kernel.org
Subject: I hope to hear from you
Date: Thu, 16 Jan 2025 20:48:35 +0000
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Biglobe-Sender: sohma2763@mpd.biglobe.ne.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mpd.biglobe.ne.jp; s=default-1th84yt82rvi; t=1737060515;
 bh=0ZUcyad6sxXkwgWdJswDFb7/pkaEj4rpuiUJtgvSow0=;
 h=From:Reply-To:To:Subject:Date;
 b=lMop1ep9rXG3kp56RDsMvTzgOf7GSBLUjjpgQbNx9Vw/2MRmadF0EpVRtmnm85ly7cX0i/4f
 hl53/IJKBnjTYNDbfDnlM2BeybzvFRBn28JLO/aMTi3TggarKSZEjnAkXw5iNOB777j9yomYvZ
 lMk0DtCz0QQ73LnUdk0kaKdsGkHcw6/d+dVKxVUpFi5dlAo/OhDWG09fZEVb6UVfz0jLQMauHG
 y5CBGSq9TOKPhTeR3yF1lE/z/LwYKpyQU6qMHsGYRzE1T1i41WwlXLkHnjod+PiBKXThd7EM4H
 TXBZaHkDeUTJV8k7plfNHbAPFhZqI2lyZY0LFy4yPDKMIEOQ==

Hello there,

Hello, I have been trying to contact you, kindly reply when you see this  email.

