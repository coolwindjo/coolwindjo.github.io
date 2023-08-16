---
layout: post
title: How to add a ssh-key to your github account
categories: SensorFusionProject
tags: [getting-started, ssh, git]
---

## Related Posts

- [SensorFusionProject Category](<https://coolwindjo.github.io/categories.html#h-SensorFusionProject>){:target="_blank"} 

## Step by step guide

### Generate your SSH key for your convenient git work

If you don't already have an SSH key, you must generate a new SSH key. If you're unsure whether you already have an SSH key, check for existing keys.

```terminal

$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDltFNAyuz2eRra1NIdYC9Nh/3e/OQh4JXXuvFTv/s
...
4WYyGjrFOrpLMhDvO9Zo8o2tChlv1GxYpBMMAOHS1DEHUeGp3nVWF12qAT5tntVc5THy7Xw== coolwind@hotmail.co.kr

```

If you don't want to reenter your passphrase every time you use your SSH key, you can add your key to the SSH agent, which manages your SSH keys and remembers your passphrase.

Paste the text below, substituting in your GitHub email address.

```terminal

ssh-keygen -t rsa -b 4096 -C "your_github_email@example.com"

```

This creates a new ssh key, using the provided email as a label.

Generating public/private rsa key pair.
When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.

Enter a file in which to save the key (/c/Users/you/.ssh/id_rsa):[Press enter]
At the prompt, type a secure passphrase. For more information, see "Working with SSH key passphrases".
Enter passphrase (empty for no passphrase): [Type a passphrase]
Enter same passphrase again: [Type passphrase again]

Now, check for your new generated key.

```terminal

$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDltFNAyuz2eRra1NIdYC9Nh/3e/OQh4JXXuvFTv/s
...
4WYyGjrFOrpLMhDvO9Zo8o2tChlv1GxYpBMMAOHS1DEHUeGp3nVWF12qAT5tntVc5THy7Xw== coolwind@hotmail.co.kr

```

### Add the SSH key to your GitHub account

- Go to Settings on your GitHub Profile
![Add the SSH key to your GitHub account 1]({{ "/assets/images/posts/2020-11-26/github_page1.png" | relative_url }})

- Find the button saying New SSH key and Click it
![Add the SSH key to your GitHub account 2]({{ "/assets/images/posts/2020-11-26/github_page2.png" | relative_url }})

- Paste the string you've got from the terminal and set a nickname for the SSH key
![Add the SSH key to your GitHub account 3]({{ "/assets/images/posts/2020-11-26/github_page3.png" | relative_url }})


It's done!
