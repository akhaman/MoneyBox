//
//  FormSheetPresentationController.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 25.09.2021.
//

import UIKit

final class CardFormTransitioningManager: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {

        CardFormPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

private final class CardFormPresentationController: UIPresentationController {

    private lazy var dimmingView = UIView()

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }

        let containerViewBounds = containerView.bounds

        var presentedViewFrame: CGRect = .zero

        presentedViewFrame.size = size(
            forChildContentContainer: presentedViewController,
            withParentContainerSize: containerViewBounds.size
        )

        presentedViewFrame.origin.x = (containerViewBounds.size.width - presentedViewFrame.size.width) / 2
        presentedViewFrame.origin.y = (containerViewBounds.size.height - presentedViewFrame.size.height) / 2

        return presentedViewFrame
    }

    override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        configureDimmingView()
    }

    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView else { return }
        presentedView?.frame = frameOfPresentedViewInContainerView
        dimmingView.frame = containerView.bounds
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        CGSize(width: parentSize.width - 32, height: parentSize.height * 0.5)
    }
}

// MARK: - Presentation Animation

extension CardFormPresentationController {

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView,
              let transitionCoordinator = presentedViewController.transitionCoordinator,
              let presentedView = presentedView else { fatalError("One of the required views are nil") }

        containerView.insertSubview(dimmingView, at: 0)
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0

        presentedView.layer.cornerRadius = 35
        presentedView.frame = frameOfPresentedViewInContainerView

        guard let presentedSnapshotView = presentedView.snapshotView(afterScreenUpdates: true) else { return }
        containerView.addSubview(presentedSnapshotView)
        presentedSnapshotView.frame = frameOfPresentedViewInContainerView
        presentedSnapshotView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        presentedSnapshotView.alpha = 0

        presentedView.alpha = 0

        transitionCoordinator.animate(
            alongsideTransition: { _ in
                self.dimmingView.alpha = 1
                presentedSnapshotView.transform = .identity
                presentedSnapshotView.alpha = 1
            },
            completion: { _ in
                presentedView.alpha = 1
                presentedSnapshotView.removeFromSuperview()
            })
    }
}

// MARK: - Dismissal Animation

extension CardFormPresentationController {

    override func dismissalTransitionWillBegin() {
        guard let transitionCoordinator = presentedViewController.transitionCoordinator,
              let presentedView = presentedView,
              let presentedSnapshotView = presentedView.snapshotView(afterScreenUpdates: false) else { return }

        containerView?.addSubview(presentedSnapshotView)
        presentedSnapshotView.frame = frameOfPresentedViewInContainerView

        presentedView.alpha = 0

        transitionCoordinator.animate { _ in
            self.dimmingView.alpha = 0
            presentedSnapshotView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            presentedSnapshotView.alpha = 0
        } completion: { _ in
            self.dimmingView.removeFromSuperview()
            presentedSnapshotView.removeFromSuperview()
        }
    }
}

// MARK: - Dimming View configuration

extension CardFormPresentationController {

    private func configureDimmingView() {
        dimmingView.backgroundColor = .black.withAlphaComponent(0.5)
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDimmingViewTapped)))
    }

    @objc func onDimmingViewTapped() {
        presentedViewController.dismiss(animated: true)
    }
}
