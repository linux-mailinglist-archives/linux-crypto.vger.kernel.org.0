Return-Path: <linux-crypto+bounces-23648-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADwROqWH+GkZwQIAu9opvQ
	(envelope-from <linux-crypto+bounces-23648-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 13:48:53 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1B4BC9BB
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 13:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D31C3025913
	for <lists+linux-crypto@lfdr.de>; Mon,  4 May 2026 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6834E3C13E1;
	Mon,  4 May 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="am0cYw1q";
	dkim=permerror (0-bit key) header.d=chronox.de header.i=@chronox.de header.b="cTCY3I2G"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E83C0634;
	Mon,  4 May 2026 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895257; cv=pass; b=BM+pG9GeA+jUlnBgZvx+1jiIFHVnK1AZxp0MEoirBKwtVLfJNH/S/a++nmiEPE7loSSutQdYqJ52Ul7+vQoKApt0RZj8Q4WVLvsJSeJjiyAojwvDytZu24B4r4yRj0FqadHHWAxnjzMfqGN5uPlEtPRaug1xF2fiJx2DmjCYsrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895257; c=relaxed/simple;
	bh=kLuwym4G4GXQ25ZqYuzQ4E2vgF+Oq72gMF45cEw3pn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4sZ2GvhGOX1KwmmwjqHeDoUEslT6oQDG/otQw+bEt5lwDu/rbO7vG/Dxlcc6RchOqi4F9lIKJnXW4CtUCNp0fju2cq+RqhoiKV6RjLruhwIr9daJSbEuXy1pR/dvi2I4AwdbEcI6729rxqvrgylyJq2arRt9EwM8yuEmKcscCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chronox.de; spf=none smtp.mailfrom=chronox.de; dkim=pass (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b=am0cYw1q; dkim=permerror (0-bit key) header.d=chronox.de header.i=@chronox.de header.b=cTCY3I2G; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chronox.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chronox.de
ARC-Seal: i=1; a=rsa-sha256; t=1777895253; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TfPvYyyymvOIlT2+d5czux9gVx88Z94hsh1UMquzqMkIeD5DaiND14dsULtTFVtsQI
    twT7t/K3uMsURryGLuRipwuk5JRZQPo8CxLw4cKTxCCBKTf+t5LL2vE3r5lsBl1oOcVg
    T2r41HSS9Zu10Qjh1xlu4Yxh8Uh3n158RP020DchluijSzJ9Py7mSH+bwE1m/oPN2Uvh
    sO55m7zUcmulXqq9NToW2yvOHiShK+VBk1vQ8bPbc26ofiZvHExoT4qdc3BgGUQkjmu1
    vNHV/MzsRaXFe98++Lg78N60HgWRxLz3QvigN17mJ2RgnRO8lCH1tHut6FklvQ0eKvFt
    u+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777895253;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kLuwym4G4GXQ25ZqYuzQ4E2vgF+Oq72gMF45cEw3pn4=;
    b=BPMT9iCsX+5AcBPMDPpMhqct8Zpvv8WlJ04pqu3BzmMT2JojZBdb2krnJE4Dx36Yqc
    ATQI6VJ47aK+W0KBdYJ4cFIF5D/Gd9gggsZATzEr2RPBstpFrIL2VnZXzXO2kuZ3fxcb
    XqPGl8wUkoIUaFb/eQX5ezH57ja1R3554Q7u+bAJnYJFecR8gqbwFfd0erbdlVjwIbaF
    m4chO2B9O9ied5mYc616DoA6cqAH16jJFqzMvWQiOaD8d28jSy/tNsOGhBf+6d2dmJS4
    IjhfyaMnpVBvMjOIKEdjUypJeI9H3UPdj6gFgTZ9qpklWR4BIY2LxyfJSaD+3jBXa3xn
    Er+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777895253;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kLuwym4G4GXQ25ZqYuzQ4E2vgF+Oq72gMF45cEw3pn4=;
    b=am0cYw1q11OIDy/YaPOrhjVsH+9qHx4hKu7DBGLtYvOCwsWMSQ7aTvUp2H4qBLWUnE
    QQCdGCrZbskz3dyHeEOuXyLU76pdi8H576rDi0XdAmCSGdpvquEBwAna7SFlG39A/Dx9
    qVK07zRrNp8WY067pauFpjSxKfE4u3cE2PjcJIc7fPoqkn/2Y2NABoXzidahuRJYibXW
    KHRDG+In4j6hO5FEjesRg64+dHESNaimNiFwPMyqGrZaK6fMhSMzevPSzaU91Op3YedJ
    8aJf5Zx4mb2Gs4JoLFgX679cnAVEg9KvnbTTgcXW1Rj9m3+Z/yECVsUUjoJSR4k0nUA1
    1tDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777895253;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kLuwym4G4GXQ25ZqYuzQ4E2vgF+Oq72gMF45cEw3pn4=;
    b=cTCY3I2GCKdQaIUKLNMKhi+9NggLaUrRK6pNyKIS7JwqVqfOC+fTt1YPPA5NMV6SF5
    zHhxKtS0U0LKUef8aVAQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmwdP57PWmc+BP1jdA=="
Received: from graviton.chronox.de
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id f77920244BlWqtD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 4 May 2026 13:47:32 +0200 (CEST)
From: Stephan =?UTF-8?B?TcO8bGxlcg==?= <smueller@chronox.de>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: jitterentropy - fix URL
Date: Mon, 04 May 2026 13:47:30 +0200
Message-ID: <JlENoyPaTHK11Dr0AwpSZw@chronox.de>
In-Reply-To: <20260504082848.7194-5-thorsten.blum@linux.dev>
References:
 <20260504082848.7194-4-thorsten.blum@linux.dev>
 <20260504082848.7194-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=smueller@chronox.de;
 keydata=
 mFIEZZK4/xMIKoZIzj0DAQcCAwTDaDnchhDYEXH6dbfhyHMkiZ0HPYDF5xwHuMB8Z24SuXYdMfh
 pnovdsgwpi6LNAvnI/lGPrvDc/Mv0GQvHDxN0tCVTdGVwaGFuIE3DvGxsZXIgPHNtdWVsbGVyQG
 Nocm9ub3guZGU+iJYEExMIAD4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQQ0LE46O
 epfGZCb44quXQ2j/QkjUwUCZZK6YwIZAQAKCRCuXQ2j/QkjU/bVAP9CVqPG0Pu6L0GxryzpRkvj
 uifi4IzEoACd5oUIGmUX7AD8DxesdicM2ugqAxHgEZKl9xhi36Eq7usa/A6c6kFmyHK0HVN0ZXB
 oYW4gTcO8bGxlciA8c21AZXBlcm0uZGU+iJMEExMIADsWIQQ0LE46OepfGZCb44quXQ2j/QkjUw
 UCZZK6QgIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCRCuXQ2j/QkjU8HNAQDdTmzs+
 Cls6FMoFrzoWdYtOGCW5im7x1G5M/L0L3VOvgEA6m9edpqCc0irbdNXVjoZwTXkSsLOxs2t7aDX
 2vFX54m0KVN0ZXBoYW4gTcO8bGxlciA8c211ZWxsZXJAbGVhbmNyeXB0by5vcmc+iJMEExMIADs
 WIQQ0LE46OepfGZCb44quXQ2j/QkjUwUCZb+zewIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBw
 IXgAAKCRCuXQ2j/QkjU1pIAQDemuxTaZdMGsJp/7ghbB7gHwV5Rh5d1wghKypI0z/iYgEAxdR7t
 6KrazO07Ia9urxEAQWqi0nf6yKluD0+gmOCmsW4UgRlkrj/EwgqhkjOPQMBBwIDBBo6QjEMU/1V
 DD+tVj9qJ39qtZe5SZKFetDzXtyqRpwL+u8IbdIjv0Pvz/StziFMeomh8chRB7V/Hjz19jajK3C
 IeAQYEwgAIBYhBDQsTjo56l8ZkJvjiq5dDaP9CSNTBQJlkrj/AhsgAAoJEK5dDaP9CSNTLQwA/1
 WxGz4NvAj/icSJu144cMWOhyeIvHfgAkG9sg9HZXGdAPsGzKo4SezAYCwqgFKnyUIAjKYl1EW79
 pSCOFS36heQvbhWBGWSuP8SCCqGSM49AwEHAgMEiEhJatNBgxidg8XJFTy8Ir7EsTCeoVY2vJAN
 rysZeAAmSaUWFD4pvXE5RYQFeCYTWTG419H7ocNGUz5u1dgKhAMBCAeIeAQYEwgAIBYhBDQsTjo
 56l8ZkJvjiq5dDaP9CSNTBQJlkrj/AhsMAAoJEK5dDaP9CSNTGCAA/A2i1CxhQJmYh2MwfeM5Hy
 Wk6EeWruSA1OgSWmaJaoGaAP4mARD2CviJgz8s3Gw07ZTk8SYHOTnv70hUbaziZ3/tjA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 3FE1B4BC9BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chronox.de,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chronox.de:s=strato-dkim-0002,chronox.de:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23648-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[chronox.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smueller@chronox.de,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]

Am Montag, 4. Mai 2026, 10:28:51 Mitteleurop=C3=A4ische Sommerzeit schrieb =
Thorsten=20
Blum:

Hi Thorsten,

> The URL https://www.chronox.de/jent.html resolves to a 404 Not Found.
> Use https://www.chronox.de/jent/ instead.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Stephan Mueller <smueller@chronox.de>

Ciao
Stephan



