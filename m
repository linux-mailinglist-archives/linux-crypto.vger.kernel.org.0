Return-Path: <linux-crypto+bounces-13745-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C486AD2E2F
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Jun 2025 08:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB143B0FE0
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Jun 2025 06:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B9527A469;
	Tue, 10 Jun 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSF9JFLD"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14627A900
	for <linux-crypto@vger.kernel.org>; Tue, 10 Jun 2025 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538668; cv=none; b=tmsX+7UVUb8iPgLzZ1Uv8B3Z2HScAiaTt7fPEdrq2sJREcMgB/nzNjz/q/b31ltNzbzlNGh8CAPqM2/Eer4d7tvsDf3UiBEtu65OJzAouiYtOrZiOrJO6LOkp7bKEy1uUzhNO+W8237XWU75zmDjOe4jOffkQ1k0s5+RCeMnqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538668; c=relaxed/simple;
	bh=wQDRUTlp4sE+EN0pOSIBNf7ckPMmbxmA2pRLWs5QQLQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mS4ACorcRy+uNS7QfhKNBSTA1iDZ5n8V6zKgm7SEjehgKToj1PsfEPXgz+QQAPZhTkI3YZC2jX9DcMNbLpsdZ7thaALGGLf1zzZXuyur+6NJuVdfdaml6VQrf6nmMc+K/3l35t1lEt/GLJk4drGv4eM/5tvKGwV4SyDlMv02H2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSF9JFLD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2363616a1a6so5583385ad.3
        for <linux-crypto@vger.kernel.org>; Mon, 09 Jun 2025 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749538666; x=1750143466; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L4xukjuXu3o0NcLfkD4BlUya4WbjsrMWpKI/1kjJCc=;
        b=fSF9JFLDuwXCE05GePiW0Qqb0OQq0ETOwLLOwRqLWNhY4YghAeV+wa5UEAkq38o0L+
         Cp8t6i61KMKHLmYtM3xIVEn2JkwGo21AE+PMtzjwTLq4ljJYQqKpG6ejD//laqUTkaYH
         bZcgFpXczZL+5IrT2w6b5RdTJNMMPre04vlLFC98/spHaYxbfzXHZK48tbi0v/T07H7O
         GiWQLssDcCZKKnjqss6MHXt1iz1rhx8QEr3529NH6LEsE8mK6KSDo5I/mGQJwGr7d1EQ
         JZOPq/QHZivhc0FkD7UlpQoea0ZBM74AJzZo/Fkkl316xtn78txBWTNIJmTWXBQiPncD
         TYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749538666; x=1750143466;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L4xukjuXu3o0NcLfkD4BlUya4WbjsrMWpKI/1kjJCc=;
        b=lkPZN+uHZ2++l88WROu9YD+D99ER27W3gGt66mQsn6fL+0sNsGDJdSG0ecNU8OPI3U
         UEa9mwTZf2uL0HbjMw8D2cjgqwkR2SURA5D47/YTsQ4+BNaHfM4V4JzBNYNuwq/r3gBP
         SAWkAgAb4EaStxxRijKmAqbRtKTxbZWZWBIwRQB23h8gydRRJoXffoRCOkxWbuq57+2Y
         7eNv/VOugdWrEXYhP8zMcsgoAVS8KftlssFYvD8k8YqzsQD8lZ+q39RJsz409lUMUQM6
         4YjmFi8C6UHlNaSN8AGpOqfUuT43+hRGbLi3gIkEtjPbAHRA6uV/wK4dlgJchr6CA6fP
         QJCg==
X-Gm-Message-State: AOJu0YwUNBwXFmlEziDr3ld/7khzTlR7T4/mqZ7cCtH+NeS1QQ/bRZDa
	RaECX/hhrpDRsmKrlwSq9wCBN1jjyjPD48WLwi+Yya8vkusgq6kkf+us
X-Gm-Gg: ASbGncthM8c6FAoe5I5IOazIgJm+uk0q1My5ecbp2Q6QgWofpybhQnrlqGXLBApQltf
	V2sVioqK3ibseq6OQALDQ8Y4RGOf3SAxchexw2dwLSeu2MR0ljxFTBWA75K/igsOiEeVsN13Axp
	K79OHhQDeIg/eue28a9ujnVqm+CanxbWeNR4WwTcJifF3SlfcnSlNxkqFsRNj4DrLZfPcT9paQA
	ZyEQhensie51Fj0NxIs4Q0x7LMWl/4T84bAB3cpPzFVdDNsrSerwjKOygdITXbvmmLw54zTe2Fz
	CxsVH39ulLwzipINn27E3W00eYr8tMfxpGlbxC7G7lFmr8MlC5mTsMUKmI6w8UIiJXVnv10mM9Q
	fbro=
X-Google-Smtp-Source: AGHT+IH4bjAX98tWFNKtoOACDhCgsCpt0WZwKnbIRTxkTlg0omIJbHw9927Nx6yXkn4NuPf+PcKx5g==
X-Received: by 2002:a17:902:ea04:b0:234:f4da:7eeb with SMTP id d9443c01a7336-23601cf42a7mr206871195ad.7.1749538666564;
        Mon, 09 Jun 2025 23:57:46 -0700 (PDT)
Received: from smtpclient.apple ([209.9.201.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc9d2sm64668825ad.113.2025.06.09.23.57.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jun 2025 23:57:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3] crypto: riscv/poly1305 - import OpenSSL/CRYPTOGAMS
 implementation
From: Zhihang Shao <zhihang.shao.iscas@gmail.com>
In-Reply-To: <20250609201306.GD1255@sol>
Date: Tue, 10 Jun 2025 14:57:29 +0800
Cc: linux-crypto@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 herbert@gondor.apana.org.au,
 paul.walmsley@sifive.com,
 alex@ghiti.fr,
 appro@cryptogams.org,
 zhang.lyra@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC8AB5A0-D5C9-4D18-A986-DE66BE46E09A@gmail.com>
References: <20250609074655.203572-3-zhihang.shao.iscas@gmail.com>
 <20250609201306.GD1255@sol>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


>> +void poly1305_blocks_arch(struct poly1305_block_state *state, const =
u8 *src,
>> +  unsigned int len, u32 padbit)
>> +{
>> + len =3D round_down(len, POLY1305_BLOCK_SIZE);
>> + poly1305_blocks(state, src, len, 1);
>> +}
>> +EXPORT_SYMBOL_GPL(poly1305_blocks_arch);
>=20
> This is ignoring the padbit and forcing it to 1, so this will compute =
the wrong
> Poly1305 value for messages with length not a multiple of 16 bytes.

So Does this mean here the argument of poly1305_blocks should be fixed =
as poly1305_blocks(state, src, len, padbit)?
But since the padbit is set to 1 in poly1305_blocks_arch according to =
the implementation in lib/crypto/poly1305.c,=20
it seems to be no difference here.

Looking forward to your reply.=

