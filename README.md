# 🚀 Inception of Things: Introduction to Kubernetes with K3d and K3s using Vagrant

Welcome to the "Inception of Things" project, an immersive journey into the world of Kubernetes, with a specific emphasis on understanding K3d and K3s using Vagrant. This project is structured into three parts, each progressively building upon the knowledge gained in the preceding section.

## 🌐 Project Overview

This project offers a hands-on approach to learning Kubernetes, providing users with practical experience in deploying and managing applications on K3d and K3s through Vagrant. It aims to serve as a comprehensive introduction to Kubernetes, making it an invaluable learning opportunity for those eager to delve into this transformative technology.

## 🔧 Project Parts

### Part 1: Setting up K3s and Vagrant

In this section, we'll establish two virtual machines using Vagrant, with one in controller mode and the other in agent mode. The primary objective is to familiarize ourselves with the process of setting up K3s and Vagrant, gaining insights into how K3s operates.

### Part 2: Setting up K3s and Three Simple Applications

This part involves configuring a virtual machine with K3s in server mode and deploying three web applications. The aim is to deepen understanding of deploying applications on K3s and enhance comprehension of Kubernetes functionality.

### Part 3: Setting up K3d and Argo CD

Here, we'll set up K3d, a lightweight Kubernetes distribution within Docker, and Argo CD, a GitOps continuous delivery tool for Kubernetes. This section focuses on understanding K3d and Argo CD, showcasing their utility in a production environment.

### 🎁 Bonus: Installing Helm 3 and GitLab

In addition to the main parts of the project, you can also install Helm 3 and GitLab to further immerse yourself in the world of Kubernetes. Helm 3 is a package management tool for Kubernetes, and GitLab is an open-source DevOps application. Instructions for Helm 3 installation can be found [here](https://helm.sh/docs/intro/install/), and for GitLab installation on Kubernetes, you can use the official Helm chart available [here](https://gitlab.com/gitlab-org/charts/gitlab/).

## 🚧 Getting Started

This project includes a Makefile to simplify common tasks. Ensure that you have Vagrant and other dependencies installed before proceeding.

### Installing Vagrant

To install Vagrant on Ubuntu, run the following command:

```bash
make install-vagrant
```

## 🏁 Conclusion

This project provides a comprehensive introduction to Kubernetes and serves as a valuable learning opportunity for those interested in this technology. By following the guidelines and utilizing the resources provided, users can deepen their understanding of Kubernetes and gain experience with K3d and K3s. We hope that this project will help users become more proficient with Kubernetes and that it will serve as a starting point for further exploration of this exciting technology.

## 📚 Resources

To support this project, we provide the following resources:

- Official documentation for [Vagrant](https://www.vagrantup.com/docs/)
- Official documentation for [Kubernetes](https://kubernetes.io/docs/)
- Official documentation for [K3s](https://rancher.com/docs/k3s/latest/en/)
- Official documentation for [K3d](https://k3d.io/)
- Examples of [Vagrantfiles](https://github.com/hashicorp/vagrant/tree/master/examples) for creating virtual machines
- Examples of [Kubernetes configuration files](https://github.com/kubernetes/examples)
- Examples of applications running on Kubernetes: [Kubernetes Examples](https://github.com/kubernetes/examples/tree/master/staging)
- Online course on Kubernetes from [Linux Academy](https://linuxacademy.com/course/kubernetes-essentials/)
- Free online course on Kubernetes from [edX](https://www.edx.org/course/introduction-to-kubernetes)
- Article on using Vagrant for Kubernetes development on [Habr](https://habr.com/ru/company/flant/blog/331524/)
- Official [GitLab documentation](https://docs.gitlab.com/)
- Official [Helm documentation](https://helm.sh/docs/)
- Official [Kubernetes documentation](https://kubernetes.io/docs/)
- Examples of [Helm charts](https://artifacthub.io/)
- Kubernetes courses on [Pluralsight](https://www.pluralsight.com/browse/kubernetes)
- Articles and tutorials on Kubernetes on [Medium](https://medium.com/tag/kubernetes)
