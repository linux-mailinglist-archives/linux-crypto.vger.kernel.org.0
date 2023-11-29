Return-Path: <linux-crypto+bounces-377-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0B87FD120
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 09:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D218CB2151B
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF75125AE
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VNPbU2vf"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B6B94
	for <linux-crypto@vger.kernel.org>; Tue, 28 Nov 2023 23:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701241249; x=1701500449;
	bh=13n/FbsdAD63nCkWt8PGe520xE44G8Ft09Wg1OcHD3Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VNPbU2vfX5cEqEWL5/9Mpla20+qB55j4wsDkMY1tUWUxDP72Ks8TLJqMjT7vC3eFq
	 GgjgoxuwPeiLvKi+HE12lkn2O7SkFlEQG01i0NpP3MRMloJ9iS4zKpIJVjhnXehHXp
	 Xz6qEKCIZeb3Tk2z+ZQsOGR7R/PH8tb9MWhdLUngoWnQw4dwATYkmFf4uAZfy4OhwM
	 oBneMrWzlmVWQC2BcEyOMiKbtxGeZN+1y/DznwLOOa8PD3PSoOSs/THR+6qdai5tyK
	 aZYRe7Z+rGkqjJrIOUBq44MZqb9JhkySb0d8maQtOL2UzjO4bmAO3E5bwMqf7E1PZL
	 23GPOiq3xulKQ==
Date: Wed, 29 Nov 2023 07:00:42 +0000
To: Yusong Gao <a869920004@gmail.com>
From: Juerg Haefliger <juergh@proton.me>
Cc: jarkko@kernel.org, davem@davemloft.net, dhowells@redhat.com, dwmw2@infradead.org, zohar@linux.ibm.com, herbert@gondor.apana.org.au, lists@sapience.com, dimitri.ledkov@canonical.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v5] sign-file: Fix incorrect return values check
Message-ID: <20231129080033.12c4efe3@smeagol>
In-Reply-To: <20231127033456.452151-1-a869920004@gmail.com>
References: <20231127033456.452151-1-a869920004@gmail.com>
Feedback-ID: 45149698:user:proton
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_bqlWVBJFFpdDPXWzuVv4Sbw8of9oHqNZBSjRct5izU"

This is a multi-part message in MIME format.

--b1_bqlWVBJFFpdDPXWzuVv4Sbw8of9oHqNZBSjRct5izU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Nov 2023 03:34:56 +0000
"Yusong Gao" <a869920004@gmail.com> wrote:

> There are some wrong return values check in sign-file when call OpenSSL
> API. The ERR() check cond is wrong because of the program only check the
> return value is < 0 which ignored the return val is 0. For example:
> 1. CMS_final() return 1 for success or 0 for failure.
> 2. i2d_CMS_bio_stream() returns 1 for success or 0 for failure.
> 3. i2d_TYPEbio() return 1 for success and 0 for failure.
> 4. BIO_free() return 1 for success and 0 for failure.
>=20
> Link: https://www.openssl.org/docs/manmaster/man3/
> Fixes: e5a2e3c84782 ("scripts/sign-file.c: Add support for signing with a=
 raw signature")
> Signed-off-by: Yusong Gao <a869920004@gmail.com>
> ---
> V1, V2: Clarify the description of git message.
> V3: Removed redundant empty line.
> V4: Change to more strict check mode.
> ---
>  scripts/sign-file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 598ef5465f82..3edb156ae52c 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -322,7 +322,7 @@ int main(int argc, char **argv)
>  =09=09=09=09     CMS_NOSMIMECAP | use_keyid |
>  =09=09=09=09     use_signed_attrs),
>  =09=09    "CMS_add1_signer");
> -=09=09ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
> +=09=09ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) !=3D 1,
>  =09=09    "CMS_final");
>=20
>  #else
> @@ -341,10 +341,10 @@ int main(int argc, char **argv)
>  =09=09=09b =3D BIO_new_file(sig_file_name, "wb");
>  =09=09=09ERR(!b, "%s", sig_file_name);
>  #ifndef USE_PKCS7
> -=09=09=09ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
> +=09=09=09ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) !=3D 1,
>  =09=09=09    "%s", sig_file_name);
>  #else
> -=09=09=09ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
> +=09=09=09ERR(i2d_PKCS7_bio(b, pkcs7) !=3D 1,
>  =09=09=09    "%s", sig_file_name);
>  #endif
>  =09=09=09BIO_free(b);
> @@ -374,9 +374,9 @@ int main(int argc, char **argv)
>=20
>  =09if (!raw_sig) {
>  #ifndef USE_PKCS7
> -=09=09ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
> +=09=09ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) !=3D 1, "%s", dest_name);
>  #else
> -=09=09ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
> +=09=09ERR(i2d_PKCS7_bio(bd, pkcs7) !=3D 1, "%s", dest_name);
>  #endif
>  =09} else {
>  =09=09BIO *b;
> @@ -396,7 +396,7 @@ int main(int argc, char **argv)
>  =09ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
>  =09ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", =
dest_name);
>=20
> -=09ERR(BIO_free(bd) < 0, "%s", dest_name);
> +=09ERR(BIO_free(bd) !=3D 1, "%s", dest_name);
>=20
>  =09/* Finally, if we're signing in place, replace the original. */
>  =09if (replace_orig)
> --
> 2.34.1
>=20

Nit: v5 in the email subject should be v4.

Reviewed-by: Juerg Haefliger <juerg.haefliger@canonical.com>


--b1_bqlWVBJFFpdDPXWzuVv4Sbw8of9oHqNZBSjRct5izU
Content-Type: application/pgp-signature; name=attachment.sig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=attachment.sig

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFJekJBRUJDZ0FkRmlFRWhaZlU5Nkl1
cHJ2aUxkZUxEOU9MQ1F1bVFyY0ZBbVZtNFpFQUNna1FEOU9MQ1F1bQ0KUXJjeWJSQUFpQjJsK1FQ
TkRTaWxTTTJmVW14dVJFS2xXdDFCclp3Q001QU53U2JpcHZBSVV1VUJFUW9wNGhhOQ0KZ2t5dTVH
YVJMc0RXRVVPdjBROVA1ZEtyUVRhWUdkc3M0aXlOZHFLbmRhNXpsNWhSNEVNR0tYb1JDeGozam54
Rg0KQ2ZCb3VDblVacUZWeTdETjQ5ZTVqU2JuNEtRREhRdHJ5dm5XSEk2ck10dm5XbnhsY0tpMnpj
RFNSTzdHN1NuYg0Ka3YwQ2ZkZ0hYbUkyRlZXREU1QkNQdjB0ay9janFLUW1JcmY1c0E3Wmozby9P
b1Z6SDRaOE5Ha01oMlRsL3lmUQ0KVGk3S0RSWFlaNzllZTVRV2lPUzd3bjQ0SG9Vb0xiN0tPMnF5
TmJ4bVM1VTRNZDdmejJRL0F5VDkwTmFEU293Mw0KaWJUQ2dYVS8wd0xCNzdhdnR0WVhoL1lUaWxF
ZjB1VVB1RDVxOWh1YTBwdFgzRnFWWURWZndvUi8vQU1MNjFMaA0KVXFTVTRzY0FtSkc4S2h0bW9r
NlhKS0RVRno2Y0FSQXg3RmFoaGJqT01CMjFxcFhSMk8vSzNGd1N5ZFZXbElUZA0KeHZYSWZsWSt5
ZEJTZXhQQi9oeFFnZ2VQYUdZVzdSUUh5OHV5ZnREaHZ2bk5zRjZibjFzNTQ4WGtmeW96dGhWMA0K
WUZKeVlXVVFyVnNjbTM5VGwwT09GSjRlUlNVUlU4ZWc1TkFTdVVRQW5HbTNNYTEzeHZ0RkZ4OEp4
MW13Y01jZg0KSGhsQkx6aG12c2g4RWRDZy93V1NTK1BtRDZRVXd2NzlLY3BKMjFEY0RtaDhZbHBL
VHBnT2tVNVVKelhJZk52dQ0KaG5uNTQyOTV3QU5iRE5QVXJqWXlkTVdrRnFDei9KeG1yeTBQLzhY
dVlYSXROYmc1SWRvPQ0KPWxvWVQNCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K

--b1_bqlWVBJFFpdDPXWzuVv4Sbw8of9oHqNZBSjRct5izU--


