Return-Path: <linux-crypto+bounces-9979-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA84CA3E6C2
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Feb 2025 22:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A307A502C
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Feb 2025 21:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6182641F8;
	Thu, 20 Feb 2025 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1OMq2Xq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3F26388E
	for <linux-crypto@vger.kernel.org>; Thu, 20 Feb 2025 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087468; cv=none; b=e7zUkiHssMaLaZxH89mpfO2uTkwajIOCmcnf+KmIZCKXy2awA2eXyAMrREYpskNFUX13x5ARTTVh7khhV0u9K0tqbobz+vW8lApFuow1v33Cv3Yr3ugIRgzycF40a6WUykWw/xqNsHkcUfceeUVC1ioQqyJdwhYj6aDm82Ey0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087468; c=relaxed/simple;
	bh=88xel4ReXmml0Y0dgHmn02RadkL5KzYs1W8CvR4jbJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g52TX8B2Hpa8vmFTJr5Y0vhcFJORGDMWVIr9HHEaMhLxPiYTyHmIoBVXy5V/YFmpcR4faoDMnp0cd5K+mzo0VSYH82nC3HaNwKli1pNlL93ltabF8erE9gP+PYIJ5jbtaCImQo4sNZg+GdsQdkTRFECGFsEpMAnyCLirZGa+ZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1OMq2Xq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso256750066b.1
        for <linux-crypto@vger.kernel.org>; Thu, 20 Feb 2025 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740087465; x=1740692265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJgY/DEAxcJuwoGxKe8jJ8rEYcAL/Pax8Zc7JijGPQM=;
        b=E1OMq2XqIw5/ZO8mSSnaZsaif7vAgFMIgaOn7PhvvAY4clm0GgDXOQnhAmlkOq6kXd
         vMHF8QG78PFKsQZLxA+I5SYYxjEdeo85M5SOZPXtGjjysBjT9Y1zt/n89eB67C++334T
         /9QLBarLfPkOqdfMQ+4XyNCp1Wp6AwMeIyVAP8Qpcg1Cbc69dKXuvCHfHX1Ir1VEEdfW
         itGao2LDQZG9aBFqyHq9yu0TP3fgiKINqWAd9szHC7HMfjkYl7Y17I7rfYGP+wEf9PoG
         6ZWuItuD0zE5+BKUiVsYDtxb7GL1i3SPEhrVkWw7ZkryLA8tt9FONQFLLyzYwATxQN2n
         PKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087465; x=1740692265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJgY/DEAxcJuwoGxKe8jJ8rEYcAL/Pax8Zc7JijGPQM=;
        b=xPhGW4TmeHWoSobISWsrKxRJchTOBA/WOY2OJyNghzAby5cuM93XxK051QDqM2LSSo
         ghbVWBujeTRmbzq7ZWZuSF08Gm/UVmYXG4jlrTPvJUxa5ovKgAArqp7TIJS5a5CN6/pG
         ZVvP9hcntgUyKBnox1Zru9WjMWyGddgAwmG9u4BN1An8+kXHQEstuc4w1GJSirPgruYm
         K8XwRcRUmYvL0qPS2dwoPFoPrtUGMj402oX1OX9XA5zjuAYWHbz+6DzJtEIjGQfvGtVE
         stJL2Kv33Q0sw4/jbahBFNZjGRdq7A4HO4tiqqRmgBwjihcWa0kQJhMBmRRQHtUDsAqM
         4MCw==
X-Forwarded-Encrypted: i=1; AJvYcCV38L/q+XBQom0gXVawmI2Ue56U4lbXs6ayAIyGVO5oVnJYeBvqQXGiMh+7oZNjQi8xY0858+Jhn7vsrWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7zqO5BVe6zt+3qwd+eO/b7bvhktwrsUokEZHRdtnSSD2DVtQ
	+1psydB7BZRgV6fSMvqu850hk9wegv8/wCJhSCl82RxMESFnKhVvTA1RZP8MzXwvFOviwzQI39i
	SNsLTSO52A/ord7fLwTKOVukqor/wUsTzPOJ8
X-Gm-Gg: ASbGnctKYPw+mS71pZkYErYcmOIvBSpk1rXvhpQkCVDJRW8zzNFJGcckXOskgqzBO4E
	Ss3RVXkBun2cdd4Wlzn1tSV7mzoEY5uoMdvP3y2Xh8O+Ky0OsJcVZ6ZW1O5AVPNM+V6BMXs+eJg
	hKxCH6Z0oomecm4Op3yz44rozIIB4=
X-Google-Smtp-Source: AGHT+IHk8/fn5FhZEYC+B8X06zJ7j4NoHhOvN9+v3er2xxjzQYmLbruTLQB4WUbNewXmprb13+b2o7CIyIBuqIUXzPg=
X-Received: by 2002:a17:906:308c:b0:ab7:ec7c:89e4 with SMTP id
 a640c23a62f3a-abc09a0a2c1mr77488566b.21.1740087464402; Thu, 20 Feb 2025
 13:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739997129.git.ashish.kalra@amd.com> <f1caff4423a46c50564e625fd98932fde2a9a3fc.1739997129.git.ashish.kalra@amd.com>
 <CAAH4kHab8rvWCPX2x8cvv6Dm+uhZQxpJgwrrn2GAKzn8sqS9Kg@mail.gmail.com> <27d63f0a-f840-42df-a31c-28c8cb457222@amd.com>
In-Reply-To: <27d63f0a-f840-42df-a31c-28c8cb457222@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Thu, 20 Feb 2025 13:37:31 -0800
X-Gm-Features: AWEUYZkw8JRzTMCWoOsQe1qrRf6TLzBp_lxe1iYiNlk4nmTmKATxQq-pAaeLENg
Message-ID: <CAAH4kHYXGNTFABo7hWCQvvebiv4VkXfT8HvV-FPneyQcrHA-9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] crypto: ccp: Ensure implicit SEV/SNP init and
 shutdown in ioctls
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	herbert@gondor.apana.org.au, michael.roth@amd.com, nikunj@amd.com, 
	ardb@kernel.org, kevinloughlin@google.com, Neeraj.Upadhyay@amd.com, 
	aik@amd.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:07=E2=80=AFPM Kalra, Ashish <ashish.kalra@amd.co=
m> wrote:
>
> Hello Dionna,
>
> On 2/20/2025 10:44 AM, Dionna Amalie Glaze wrote:
> > On Wed, Feb 19, 2025 at 12:53=E2=80=AFPM Ashish Kalra <Ashish.Kalra@amd=
.com> wrote:
> >>
> >> From: Ashish Kalra <ashish.kalra@amd.com>
> >>
> >> Modify the behavior of implicit SEV initialization in some of the
> >> SEV ioctls to do both SEV initialization and shutdown and add
> >> implicit SNP initialization and shutdown to some of the SNP ioctls
> >> so that the change of SEV/SNP platform initialization not being
> >> done during PSP driver probe time does not break userspace tools
> >> such as sevtool, etc.
> >>
> >> Prior to this patch, SEV has always been initialized before these
> >> ioctls as SEV initialization is done as part of PSP module probe,
> >> but now with SEV initialization being moved to KVM module load instead
> >> of PSP driver probe, the implied SEV INIT actually makes sense and get=
s
> >> used and additionally to maintain SEV platform state consistency
> >> before and after the ioctl SEV shutdown needs to be done after the
> >> firmware call.
> >>
> >> It is important to do SEV Shutdown here with the SEV/SNP initializatio=
n
> >> moving to KVM, an implicit SEV INIT here as part of the SEV ioctls not
> >> followed with SEV Shutdown will cause SEV to remain in INIT state and
> >> then a future SNP INIT in KVM module load will fail.
> >>
> >> Similarly, prior to this patch, SNP has always been initialized before
> >> these ioctls as SNP initialization is done as part of PSP module probe=
,
> >> therefore, to keep a consistent behavior, SNP init needs to be done
> >> here implicitly as part of these ioctls followed with SNP shutdown
> >> before returning from the ioctl to maintain the consistent platform
> >> state before and after the ioctl.
> >>
> >> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> >> ---
> >>  drivers/crypto/ccp/sev-dev.c | 117 ++++++++++++++++++++++++++++------=
-
> >>  1 file changed, 93 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev=
.c
> >> index 8f5c474b9d1c..b06f43eb18f7 100644
> >> --- a/drivers/crypto/ccp/sev-dev.c
> >> +++ b/drivers/crypto/ccp/sev-dev.c
> >> @@ -1461,7 +1461,8 @@ static int sev_ioctl_do_platform_status(struct s=
ev_issue_cmd *argp)
> >>  static int sev_ioctl_do_pek_pdh_gen(int cmd, struct sev_issue_cmd *ar=
gp, bool writable)
> >>  {
> >>         struct sev_device *sev =3D psp_master->sev_data;
> >> -       int rc;
> >> +       bool shutdown_required =3D false;
> >> +       int rc, error;
> >>
> >>         if (!writable)
> >>                 return -EPERM;
> >> @@ -1470,19 +1471,26 @@ static int sev_ioctl_do_pek_pdh_gen(int cmd, s=
truct sev_issue_cmd *argp, bool wr
> >>                 rc =3D __sev_platform_init_locked(&argp->error);
> >>                 if (rc)
> >>                         return rc;
> >> +               shutdown_required =3D true;
> >>         }
> >>
> >> -       return __sev_do_cmd_locked(cmd, NULL, &argp->error);
> >> +       rc =3D __sev_do_cmd_locked(cmd, NULL, &argp->error);
> >> +
> >> +       if (shutdown_required)
> >> +               __sev_platform_shutdown_locked(&error);
> >
> > This error is discarded. Is that by design? If so, It'd be better to
> > call this ignored_error.
> >
>
> This is by design, we cannot overwrite the error for the original command=
 being issued
> here which in this case is do_pek_pdh_gen, hence we use a local error for=
 the shutdown command.
> And __sev_platform_shutdown_locked() has it's own error logging code, so =
it will be printing
> the error message for the shutdown command failure, so the shutdown error=
 is not eventually
> being ignored, that error log will assist in any inconsistent SEV/SNP pla=
tform state and
> subsequent errors.
>
> >> +
> >> +       return rc;
> >>  }
> >>
> >>  static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writ=
able)
> >>  {
> >>         struct sev_device *sev =3D psp_master->sev_data;
> >>         struct sev_user_data_pek_csr input;
> >> +       bool shutdown_required =3D false;
> >>         struct sev_data_pek_csr data;
> >>         void __user *input_address;
> >>         void *blob =3D NULL;
> >> -       int ret;
> >> +       int ret, error;
> >>
> >>         if (!writable)
> >>                 return -EPERM;
> >> @@ -1513,6 +1521,7 @@ static int sev_ioctl_do_pek_csr(struct sev_issue=
_cmd *argp, bool writable)
> >>                 ret =3D __sev_platform_init_locked(&argp->error);
> >>                 if (ret)
> >>                         goto e_free_blob;
> >> +               shutdown_required =3D true;
> >>         }
> >>
> >>         ret =3D __sev_do_cmd_locked(SEV_CMD_PEK_CSR, &data, &argp->err=
or);
> >> @@ -1531,6 +1540,9 @@ static int sev_ioctl_do_pek_csr(struct sev_issue=
_cmd *argp, bool writable)
> >>         }
> >>
> >>  e_free_blob:
> >> +       if (shutdown_required)
> >> +               __sev_platform_shutdown_locked(&error);
> >
> > Another discarded error. This function is called in different
> > locations in sev-dev.c with and without checking the result, which
> > seems problematic.
>
> Not really, if shutdown fails for any reason, the error is printed.
> The return value here reflects the value of the original command/function=
.
> The command/ioctl could have succeeded but the shutdown failed, hence,
> shutdown error is printed, but the return value reflects that the ioctl s=
ucceeded.
>
> Additionally, in case of INIT before the command is issued, the command m=
ay
> have failed without the SEV state being in INIT state, hence the error fo=
r the
> INIT command failure is returned back from the ioctl.
>
> >
> >> +
> >>         kfree(blob);
> >>         return ret;
> >>  }
> >> @@ -1747,8 +1759,9 @@ static int sev_ioctl_do_pek_import(struct sev_is=
sue_cmd *argp, bool writable)
> >>         struct sev_device *sev =3D psp_master->sev_data;
> >>         struct sev_user_data_pek_cert_import input;
> >>         struct sev_data_pek_cert_import data;
> >> +       bool shutdown_required =3D false;
> >>         void *pek_blob, *oca_blob;
> >> -       int ret;
> >> +       int ret, error;
> >>
> >>         if (!writable)
> >>                 return -EPERM;
> >> @@ -1780,11 +1793,15 @@ static int sev_ioctl_do_pek_import(struct sev_=
issue_cmd *argp, bool writable)
> >>                 ret =3D __sev_platform_init_locked(&argp->error);
> >>                 if (ret)
> >>                         goto e_free_oca;
> >> +               shutdown_required =3D true;
> >>         }
> >>
> >>         ret =3D __sev_do_cmd_locked(SEV_CMD_PEK_CERT_IMPORT, &data, &a=
rgp->error);
> >>
> >>  e_free_oca:
> >> +       if (shutdown_required)
> >> +               __sev_platform_shutdown_locked(&error);
> >
> > Again.
> >
> >> +
> >>         kfree(oca_blob);
> >>  e_free_pek:
> >>         kfree(pek_blob);
> >> @@ -1901,17 +1918,8 @@ static int sev_ioctl_do_pdh_export(struct sev_i=
ssue_cmd *argp, bool writable)
> >>         struct sev_data_pdh_cert_export data;
> >>         void __user *input_cert_chain_address;
> >>         void __user *input_pdh_cert_address;
> >> -       int ret;
> >> -
> >> -       /* If platform is not in INIT state then transition it to INIT=
. */
> >> -       if (sev->state !=3D SEV_STATE_INIT) {
> >> -               if (!writable)
> >> -                       return -EPERM;
> >> -
> >> -               ret =3D __sev_platform_init_locked(&argp->error);
> >> -               if (ret)
> >> -                       return ret;
> >> -       }
> >> +       bool shutdown_required =3D false;
> >> +       int ret, error;
> >>
> >>         if (copy_from_user(&input, (void __user *)argp->data, sizeof(i=
nput)))
> >>                 return -EFAULT;
> >> @@ -1952,6 +1960,16 @@ static int sev_ioctl_do_pdh_export(struct sev_i=
ssue_cmd *argp, bool writable)
> >>         data.cert_chain_len =3D input.cert_chain_len;
> >>
> >>  cmd:
> >> +       /* If platform is not in INIT state then transition it to INIT=
. */
> >> +       if (sev->state !=3D SEV_STATE_INIT) {
> >> +               if (!writable)
> >> +                       goto e_free_cert;
> >> +               ret =3D __sev_platform_init_locked(&argp->error);
> >
> > Using argp->error for init instead of the ioctl-requested command
> > means that the user will have difficulty distinguishing which process
> > is at fault, no?
> >
>
> Not really, in case the SEV command has still not been issued, argp->erro=
r is still usable
> and returned back to the caller (no need to use a local error here), we a=
re not overwriting
> the argp->error used for the original command/ioctl here.
>

I mean in the case that argp->error is set to a value shared by the
command and init, it's hard to know what the problem was.
I'd like to ensure that the documentation is updated to reflect that
(in this case) if PDH_CERT_EXPORT returns INVALID_PLATFORM_STATE, then
it's because the platform was not in PSTATE.UNINIT state.
The new behavior of initializing when you need to now means that you
should have ruled out INVALID_PLATFORM_STATE as a possible value from
PDH_EXPORT_CERT. Same for SNP_CONFIG.

There is not a 1-to-1 mapping between the ioctl commands and the SEV
commands now, so I think you need extra documentation to clarify the
new error space for at least pdh_export and set_config

SNP_PLATFORM_STATUS, VLEK_LOAD, and SNP_COMMIT appear to not
necessarily have a provenance confusion after looking closer.



--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

