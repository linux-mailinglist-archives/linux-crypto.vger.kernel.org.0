Return-Path: <linux-crypto+bounces-8924-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D35A02F69
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Jan 2025 19:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A416468C
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Jan 2025 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8311C1DF98F;
	Mon,  6 Jan 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNudRkuO"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D721DF749
	for <linux-crypto@vger.kernel.org>; Mon,  6 Jan 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186522; cv=none; b=R95fcpbaKK33T06aFqHKt30dgmRf8U6lwbaYOTP5wAHYYhgyL+UpLQ0yb6/cq4OJXtc7T1PM/OrZpCy7fkVRP09qWnDwljBtNSzYx1j7iOJLT8sZSD4ktx1oTN2NtXT/ASHXRGGrWWLXSenVVQ1AaF7cPLM63oFuKlwfBCYFvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186522; c=relaxed/simple;
	bh=77OXqK1pKE5Qhz3fFWo9TL5w6JvaXL4k4udFV+Qafm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER30K4yUenB/jnprPZJU49GpGQyB6dIThsZqDGo3AQsxmXzjTOucrQfaFoSFmRfwKrQBdTKc9P285pgKNUE5X+v1TO7dWxJ4MeCdhcsnmXWKeeo1X99HfDsdREmjcFzRkvv/p/1ZRhegIn9Oc9lAWGNJWRbA3lKN+0F1mnuICh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vNudRkuO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4363ae65100so151911975e9.0
        for <linux-crypto@vger.kernel.org>; Mon, 06 Jan 2025 10:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736186509; x=1736791309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOea4FiJf5jFP+FBoTJLXb4Mg+OFZZLzUoREPDbNIys=;
        b=vNudRkuOKVenSUHyqW7qXj0iBC7dxiww+GrQjUL4KyD4gsQ1mjzEK+PGu0219CKDJi
         Fc/1EQW+QJouRnDzpEpOkSBpjZ1FBe0CsqwDmoYAg6HII9TKDRdfNm9q4D5TurhOv4UD
         dCXXnW5In2dRdYh/+4E/KBXBLIorF1XrKEtHfGEQMnHn6bzuad+X4CKvw2qYq1PDUce5
         iR3fHY9M/osrIiTw7l6pQmetamTr+iDWukp+7iuqgYQ7ye7hnfgLpc248joVY3J0uHVC
         BtwDGyn/Sd+8YBlCOnM0i2euizjCJBsZeBxlye75QGBja959/qpj5HAJrlKV1syVmUzZ
         Tfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736186509; x=1736791309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOea4FiJf5jFP+FBoTJLXb4Mg+OFZZLzUoREPDbNIys=;
        b=RJFLgTJd2WvyBvU/xPf28EhpOxOLsVKSPChT5OQnFnXRHSvoGElHsZXKrhGomwsr76
         BlNa31pAR4Cqv05z+2a9IKmgKY4p/Nt7P5qd+YwAZ4u7Xv0JunCStwihJv1hLkLS6FqX
         rhgxWuMt3qfz6FYbHvEACxqFPu28LXDo3YVXlpr2vS9L0vtdn3G4yw5dZQ4hIg7gobxW
         k8N7VWaxoYCojtJ4W/a08PD4oQXfDRUpgla7TY4YeqQSLBYSGZO2KgYIYXtA5I9NzlM4
         mChmc2mvhuvlbX3JcWh/YHBvIfDKyaI3SvJcjwIdCN20mqnZAJViy7Wb+rp2IFv3H5Bv
         9HCg==
X-Forwarded-Encrypted: i=1; AJvYcCWh94RMnJJy6KjI9k5AlP61dGNOtgmH/XmA7V6FgP3EWbLar43ppnM0saZanmuzmR0C8Lm7xq6HUBvuTgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXML+wucFk9SaAFnIxy/unfoamjrLFHsynLnHzOw0GoCxBaVM
	VW3cqOqw5WXvi1gvHxcG6cS34qeVIxv+WIRvV22226JfOfs1NATN8xQ3N4wZjON+DNrDK1twqnp
	IfXWslYK5BGrHJWrzs8TjGHIa7osDViSEAxY0
X-Gm-Gg: ASbGncuASAvBCMhz4MripRnsAi4mPRo9b+tNiAd8jM98o1m80MasRAMokvjJZ30gZTi
	5pJjkceh3/l0T+CceTT3/WmLo0EFKLuut3lUWPiM=
X-Google-Smtp-Source: AGHT+IESCI03OpkPkfTFwaEJUW0BCG2OZYodV/hDOXLIouNvo1C46024+Ks+lzSVWSK6DKJw6zI+HCS/UvPXkGqL3Jk=
X-Received: by 2002:adf:979c:0:b0:38a:418e:1179 with SMTP id
 ffacd0b85a97d-38a418e13dbmr26298987f8f.2.1736186509233; Mon, 06 Jan 2025
 10:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1735931639.git.ashish.kalra@amd.com> <be4d4068477c374ca6aa5b173dc1ee46ca5af44d.1735931639.git.ashish.kalra@amd.com>
In-Reply-To: <be4d4068477c374ca6aa5b173dc1ee46ca5af44d.1735931639.git.ashish.kalra@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Mon, 6 Jan 2025 10:01:38 -0800
X-Gm-Features: AbW1kvYj-mHzoyLJ30Sfn2MLHF19btXX7kn-mo__fDMAb455VbeUvb-GfQRuYT8
Message-ID: <CAAH4kHaxpATK_dULAe67pV_k=r2LzFZrGn7pspQ2Bw0cUwo+kQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] crypto: ccp: Fix implicit SEV/SNP init and
 shutdown in ioctls
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, michael.roth@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 12:00=E2=80=AFPM Ashish Kalra <Ashish.Kalra@amd.com>=
 wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>

The subject includes "Fix" but has no "Fixes" tag in the commit message.

> Modify the behavior of implicit SEV initialization in some of the
> SEV ioctls to do both SEV initialization and shutdown and adds
> implicit SNP initialization and shutdown to some of the SNP ioctls
> so that the change of SEV/SNP platform initialization not being
> done during PSP driver probe time does not break userspace tools
> such as sevtool, etc.
>

It would be helpful to update the description with the state machine
you're trying to maintain implicitly.
I think that this changes the uapi contract as well, so I think you
need to update the documentation.

You have SEV shutdown on error for platform maintenance ioctls here,
which already have implicit init.
pdh_export gets an init if not in the init state, which wasn't already
implicit because there's a wrinkle WRT the writability permission.

snp_platform_status, snp_config, vlek_load, snp_commit now should be
callable any time, not just when KVM has initialized SNP? If there's a
caveat to the platform status, the docs need to reflect it.
I don't know how SNP_COMMIT makes sense as having an implicit
init/shutdown unless you're using it as SET_CONFIG, but I suppose it
doesn't hurt?

> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 149 +++++++++++++++++++++++++++++------
>  1 file changed, 125 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 1c1c33d3ed9a..0ec2e8191583 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1454,7 +1454,8 @@ static int sev_ioctl_do_platform_status(struct sev_=
issue_cmd *argp)
>  static int sev_ioctl_do_pek_pdh_gen(int cmd, struct sev_issue_cmd *argp,=
 bool writable)
>  {
>         struct sev_device *sev =3D psp_master->sev_data;
> -       int rc;
> +       bool shutdown_required =3D false;
> +       int rc, ret, error;
>
>         if (!writable)
>                 return -EPERM;
> @@ -1463,19 +1464,30 @@ static int sev_ioctl_do_pek_pdh_gen(int cmd, stru=
ct sev_issue_cmd *argp, bool wr
>                 rc =3D __sev_platform_init_locked(&argp->error);
>                 if (rc)
>                         return rc;
> +               shutdown_required =3D true;
> +       }
> +
> +       rc =3D __sev_do_cmd_locked(cmd, NULL, &argp->error);
> +
> +       if (shutdown_required) {
> +               ret =3D __sev_platform_shutdown_locked(&error);
> +               if (ret)
> +                       dev_err(sev->dev, "SEV: failed to SHUTDOWN error =
%#x, rc %d\n",
> +                               error, ret);
>         }
>
> -       return __sev_do_cmd_locked(cmd, NULL, &argp->error);
> +       return rc;
>  }
>
>  static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writabl=
e)
>  {
>         struct sev_device *sev =3D psp_master->sev_data;
>         struct sev_user_data_pek_csr input;
> +       bool shutdown_required =3D false;
>         struct sev_data_pek_csr data;
>         void __user *input_address;
> +       int ret, rc, error;
>         void *blob =3D NULL;
> -       int ret;
>
>         if (!writable)
>                 return -EPERM;
> @@ -1506,6 +1518,7 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cm=
d *argp, bool writable)
>                 ret =3D __sev_platform_init_locked(&argp->error);
>                 if (ret)
>                         goto e_free_blob;
> +               shutdown_required =3D true;
>         }
>
>         ret =3D __sev_do_cmd_locked(SEV_CMD_PEK_CSR, &data, &argp->error)=
;
> @@ -1524,6 +1537,13 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_c=
md *argp, bool writable)
>         }
>
>  e_free_blob:
> +       if (shutdown_required) {
> +               rc =3D __sev_platform_shutdown_locked(&error);
> +               if (rc)
> +                       dev_err(sev->dev, "SEV: failed to SHUTDOWN error =
%#x, rc %d\n",
> +                               error, rc);
> +       }
> +
>         kfree(blob);
>         return ret;
>  }
> @@ -1739,8 +1759,9 @@ static int sev_ioctl_do_pek_import(struct sev_issue=
_cmd *argp, bool writable)
>         struct sev_device *sev =3D psp_master->sev_data;
>         struct sev_user_data_pek_cert_import input;
>         struct sev_data_pek_cert_import data;
> +       bool shutdown_required =3D false;
>         void *pek_blob, *oca_blob;
> -       int ret;
> +       int ret, rc, error;
>
>         if (!writable)
>                 return -EPERM;
> @@ -1772,11 +1793,19 @@ static int sev_ioctl_do_pek_import(struct sev_iss=
ue_cmd *argp, bool writable)
>                 ret =3D __sev_platform_init_locked(&argp->error);
>                 if (ret)
>                         goto e_free_oca;
> +               shutdown_required =3D true;
>         }
>
>         ret =3D __sev_do_cmd_locked(SEV_CMD_PEK_CERT_IMPORT, &data, &argp=
->error);
>
>  e_free_oca:
> +       if (shutdown_required) {
> +               rc =3D __sev_platform_shutdown_locked(&error);
> +               if (rc)
> +                       dev_err(sev->dev, "SEV: failed to SHUTDOWN error =
%#x, rc %d\n",
> +                               error, rc);
> +       }
> +
>         kfree(oca_blob);
>  e_free_pek:
>         kfree(pek_blob);
> @@ -1893,17 +1922,8 @@ static int sev_ioctl_do_pdh_export(struct sev_issu=
e_cmd *argp, bool writable)
>         struct sev_data_pdh_cert_export data;
>         void __user *input_cert_chain_address;
>         void __user *input_pdh_cert_address;
> -       int ret;
> -
> -       /* If platform is not in INIT state then transition it to INIT. *=
/
> -       if (sev->state !=3D SEV_STATE_INIT) {
> -               if (!writable)
> -                       return -EPERM;
> -
> -               ret =3D __sev_platform_init_locked(&argp->error);
> -               if (ret)
> -                       return ret;
> -       }
> +       bool shutdown_required =3D false;
> +       int ret, rc, error;
>
>         if (copy_from_user(&input, (void __user *)argp->data, sizeof(inpu=
t)))
>                 return -EFAULT;
> @@ -1944,6 +1964,16 @@ static int sev_ioctl_do_pdh_export(struct sev_issu=
e_cmd *argp, bool writable)
>         data.cert_chain_len =3D input.cert_chain_len;
>
>  cmd:
> +       /* If platform is not in INIT state then transition it to INIT. *=
/
> +       if (sev->state !=3D SEV_STATE_INIT) {
> +               if (!writable)
> +                       return -EPERM;
> +               ret =3D __sev_platform_init_locked(&argp->error);
> +               if (ret)
> +                       goto e_free_cert;
> +               shutdown_required =3D true;
> +       }
> +
>         ret =3D __sev_do_cmd_locked(SEV_CMD_PDH_CERT_EXPORT, &data, &argp=
->error);
>
>         /* If we query the length, FW responded with expected data. */
> @@ -1970,6 +2000,13 @@ static int sev_ioctl_do_pdh_export(struct sev_issu=
e_cmd *argp, bool writable)
>         }
>
>  e_free_cert:
> +       if (shutdown_required) {
> +               rc =3D __sev_platform_shutdown_locked(&error);
> +               if (rc)
> +                       dev_err(sev->dev, "SEV: failed to SHUTDOWN error =
%#x, rc %d\n",
> +                               error, rc);
> +       }
> +
>         kfree(cert_blob);
>  e_free_pdh:
>         kfree(pdh_blob);
> @@ -1979,12 +2016,13 @@ static int sev_ioctl_do_pdh_export(struct sev_iss=
ue_cmd *argp, bool writable)
>  static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
>  {
>         struct sev_device *sev =3D psp_master->sev_data;
> +       bool shutdown_required =3D false;
>         struct sev_data_snp_addr buf;
>         struct page *status_page;
> +       int ret, rc, error;
>         void *data;
> -       int ret;
>
> -       if (!sev->snp_initialized || !argp->data)
> +       if (!argp->data)
>                 return -EINVAL;
>
>         status_page =3D alloc_page(GFP_KERNEL_ACCOUNT);
> @@ -1993,6 +2031,13 @@ static int sev_ioctl_do_snp_platform_status(struct=
 sev_issue_cmd *argp)
>
>         data =3D page_address(status_page);
>
> +       if (!sev->snp_initialized) {
> +               ret =3D __sev_snp_init_locked(&argp->error);
> +               if (ret)
> +                       goto cleanup;
> +               shutdown_required =3D true;
> +       }
> +
>         /*
>          * Firmware expects status page to be in firmware-owned state, ot=
herwise
>          * it will report firmware error code INVALID_PAGE_STATE (0x1A).
> @@ -2021,6 +2066,13 @@ static int sev_ioctl_do_snp_platform_status(struct=
 sev_issue_cmd *argp)
>                 ret =3D -EFAULT;
>
>  cleanup:
> +       if (shutdown_required) {
> +               rc =3D __sev_snp_shutdown_locked(&error, false);
> +               if (rc)
> +                       dev_err(sev->dev, "SEV-SNP: failed to SHUTDOWN er=
ror %#x, rc %d\n",
> +                               error, rc);
> +       }
> +
>         __free_pages(status_page, 0);
>         return ret;
>  }
> @@ -2029,21 +2081,38 @@ static int sev_ioctl_do_snp_commit(struct sev_iss=
ue_cmd *argp)
>  {
>         struct sev_device *sev =3D psp_master->sev_data;
>         struct sev_data_snp_commit buf;
> +       bool shutdown_required =3D false;
> +       int ret, rc, error;
>
> -       if (!sev->snp_initialized)
> -               return -EINVAL;
> +       if (!sev->snp_initialized) {
> +               ret =3D __sev_snp_init_locked(&argp->error);
> +               if (ret)
> +                       return ret;
> +               shutdown_required =3D true;
> +       }
>
>         buf.len =3D sizeof(buf);
>
> -       return __sev_do_cmd_locked(SEV_CMD_SNP_COMMIT, &buf, &argp->error=
);
> +       ret =3D __sev_do_cmd_locked(SEV_CMD_SNP_COMMIT, &buf, &argp->erro=
r);
> +
> +       if (shutdown_required) {
> +               rc =3D __sev_snp_shutdown_locked(&error, false);
> +               if (rc)
> +                       dev_err(sev->dev, "SEV-SNP: failed to SHUTDOWN er=
ror %#x, rc %d\n",
> +                               error, rc);
> +       }
> +
> +       return ret;
>  }
>
>  static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool =
writable)
>  {
>         struct sev_device *sev =3D psp_master->sev_data;
>         struct sev_user_data_snp_config config;
> +       bool shutdown_required =3D false;
> +       int ret, rc, error;
>
> -       if (!sev->snp_initialized || !argp->data)
> +       if (!argp->data)
>                 return -EINVAL;
>
>         if (!writable)
> @@ -2052,17 +2121,34 @@ static int sev_ioctl_do_snp_set_config(struct sev=
_issue_cmd *argp, bool writable
>         if (copy_from_user(&config, (void __user *)argp->data, sizeof(con=
fig)))
>                 return -EFAULT;
>
> -       return __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->er=
ror);
> +       if (!sev->snp_initialized) {
> +               ret =3D __sev_snp_init_locked(&argp->error);
> +               if (ret)
> +                       return ret;
> +               shutdown_required =3D true;
> +       }
> +
> +       ret =3D __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->e=
rror);
> +
> +       if (shutdown_required) {
> +               rc =3D __sev_snp_shutdown_locked(&error, false);
> +               if (rc)
> +                       dev_err(sev->dev, "SEV-SNP: failed to SHUTDOWN er=
ror %#x, rc %d\n",
> +                               error, rc);
> +       }
> +
> +       return ret;
>  }
>
>  static int sev_ioctl_do_snp_vlek_load(struct sev_issue_cmd *argp, bool w=
ritable)
>  {
>         struct sev_device *sev =3D psp_master->sev_data;
>         struct sev_user_data_snp_vlek_load input;
> +       bool shutdown_required =3D false;
> +       int ret, rc, error;
>         void *blob;
> -       int ret;
>
> -       if (!sev->snp_initialized || !argp->data)
> +       if (!argp->data)
>                 return -EINVAL;
>
>         if (!writable)
> @@ -2081,8 +2167,23 @@ static int sev_ioctl_do_snp_vlek_load(struct sev_i=
ssue_cmd *argp, bool writable)
>
>         input.vlek_wrapped_address =3D __psp_pa(blob);
>
> +       if (!sev->snp_initialized) {
> +               ret =3D __sev_snp_init_locked(&argp->error);
> +               if (ret)
> +                       goto cleanup;
> +               shutdown_required =3D true;
> +       }
> +
>         ret =3D __sev_do_cmd_locked(SEV_CMD_SNP_VLEK_LOAD, &input, &argp-=
>error);
>
> +       if (shutdown_required) {
> +               rc =3D __sev_snp_shutdown_locked(&error, false);
> +               if (rc)
> +                       dev_err(sev->dev, "SEV-SNP: failed to SHUTDOWN er=
ror %#x, rc %d\n",
> +                               error, rc);
> +       }
> +
> +cleanup:
>         kfree(blob);
>
>         return ret;
> --
> 2.34.1
>


--
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

